import 'package:cloud_firestore/cloud_firestore.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStudent({
    required String name,
    required String email,
    required String phone,

    required String parentName,
    required String parentPhone,
    required String parentEmail,

    required String batch,
  }) async {
    await _firestore.collection('students').add({
      'name': name,
      'email': email,
      'phone': phone,

      'parentName': parentName,
      'parentPhone': parentPhone,
      'parentEmail': parentEmail,

      'batch': batch,

      // Future use
      'photoUrl': '',

      // Ranking
      'recentRank': 0,
      'overallRank': 0,
      'batchRank': 0,

      // Stats
      'presentCount': 0,
      'absentCount': 0,

      // Fee Summary
      'totalPaid': 0,
      'pendingFees': 0,

      'active': true,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getStudents() {
    return _firestore
        .collection('students')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getStudentById(String studentId) async {
    return await _firestore.collection('students').doc(studentId).get();
  }

  Future<void> updateStudent(
    String studentId, {
    required String name,
    required String email,
    required String phone,

    required String parentName,
    required String parentPhone,
    required String parentEmail,

    required String batch,
  }) async {
    await _firestore.collection('students').doc(studentId).update({
      'name': name,
      'email': email,
      'phone': phone,

      'parentName': parentName,
      'parentPhone': parentPhone,
      'parentEmail': parentEmail,

      'batch': batch,
    });
  }

  Future<void> deleteStudent(String docId) async {
    await _firestore.collection('students').doc(docId).delete();
  }
}
