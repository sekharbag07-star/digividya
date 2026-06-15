import 'package:cloud_firestore/cloud_firestore.dart';

class RankingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> calculateRecentRanks() async {
    final resultsSnapshot = await _firestore
        .collection('results')
        .orderBy('createdAt', descending: true)
        .get();

    if (resultsSnapshot.docs.isEmpty) return;

    final latestExamId = resultsSnapshot.docs.first['examId'];

    final latestExamResults = await _firestore
        .collection('results')
        .where('examId', isEqualTo: latestExamId)
        .get();

    final students = latestExamResults.docs.toList();

    students.sort((a, b) => (b['total'] as int).compareTo(a['total'] as int));

    for (int i = 0; i < students.length; i++) {
      final studentId = students[i]['studentId'];

      await _firestore.collection('students').doc(studentId).update({
        'recentRank': i + 1,
      });
    }
  }

  Future<void> calculateOverallRanks() async {
    final studentsSnapshot = await _firestore.collection('students').get();

    for (final student in studentsSnapshot.docs) {
      final studentId = student.id;

      final results = await _firestore
          .collection('results')
          .where('studentId', isEqualTo: studentId)
          .get();

      if (results.docs.isEmpty) continue;

      int totalMarks = 0;

      for (final result in results.docs) {
        totalMarks += (result['total'] as int);
      }

      final average = totalMarks / results.docs.length;

      await _firestore.collection('students').doc(studentId).update({
        'averageScore': average,
      });
    }

    final updatedStudents = await _firestore.collection('students').get();

    final rankingList = updatedStudents.docs.toList();

    rankingList.sort(
      (a, b) => ((b.data()['averageScore'] ?? 0) as num).compareTo(
        (a.data()['averageScore'] ?? 0) as num,
      ),
    );

    for (int i = 0; i < rankingList.length; i++) {
      await _firestore.collection('students').doc(rankingList[i].id).update({
        'overallRank': i + 1,
      });
    }
  }

  Future<void> updateAllRanks() async {
    await calculateRecentRanks();
    await calculateOverallRanks();
  }
}
