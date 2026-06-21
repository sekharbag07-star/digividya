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

    students.sort(
      (a, b) =>
          ((b['total'] ?? 0) as num).compareTo(((a['total'] ?? 0) as num)),
    );

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

      if (results.docs.isEmpty) {
        await _firestore.collection('students').doc(studentId).update({
          'averageScore': 0,
          'overallRank': 0,
        });
        continue;
      }

      double totalMarks = 0;

      for (final result in results.docs) {
        totalMarks += ((result['total'] ?? 0) as num).toDouble();
      }

      final average = totalMarks / results.docs.length;

      await _firestore.collection('students').doc(studentId).update({
        'averageScore': average,
      });
    }

    final updatedStudents = await _firestore.collection('students').get();

    final rankingList = updatedStudents.docs
        .where((e) => ((e.data()['averageScore'] ?? 0) as num) > 0)
        .toList();

    rankingList.sort(
      (a, b) => ((b.data()['averageScore'] ?? 0) as num).compareTo(
        ((a.data()['averageScore'] ?? 0) as num),
      ),
    );

    for (int i = 0; i < rankingList.length; i++) {
      await _firestore.collection('students').doc(rankingList[i].id).update({
        'overallRank': i + 1,
      });
    }
  }

  Future<void> calculateBatchRanks() async {
    final batches = await _firestore.collection('batches').get();

    for (final batch in batches.docs) {
      final batchId = batch.id;

      final students = await _firestore
          .collection('students')
          .where('batchId', isEqualTo: batchId)
          .get();

      final studentList = students.docs
          .where((e) => ((e.data()['averageScore'] ?? 0) as num) > 0)
          .toList();

      studentList.sort(
        (a, b) => ((b.data()['averageScore'] ?? 0) as num).compareTo(
          ((a.data()['averageScore'] ?? 0) as num),
        ),
      );

      for (int i = 0; i < studentList.length; i++) {
        await _firestore.collection('students').doc(studentList[i].id).update({
          'batchRank': i + 1,
        });
      }
    }

    final unassignedStudents = await _firestore
        .collection('students')
        .where('batchId', isEqualTo: '')
        .get();

    for (final student in unassignedStudents.docs) {
      await _firestore.collection('students').doc(student.id).update({
        'batchRank': 0,
      });
    }
  }

  Future<void> updateAllRanks() async {
    await calculateRecentRanks();
    await calculateOverallRanks();
    await calculateBatchRanks();
  }
}







