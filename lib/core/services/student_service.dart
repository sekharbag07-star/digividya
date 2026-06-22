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
  }) async {
    final existing = await _firestore
        .collection('students')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      throw Exception('Student already exists with this email');
    }

    await _firestore.collection('students').add({
      // Student
      'name': name,
      'email': email,
      'phone': phone,

      // Parent
      'parentName': parentName,
      'parentPhone': parentPhone,
      'parentEmail': parentEmail,

      // Batch
      'batchId': '',
      'batchName': 'Not Assigned',

      // Assigned Teacher
      'assignedTeacherId': '',
      'assignedTeacherName': '',

      // Language
      'preferredLanguage': 'en',

      // AI
      'aiEnabled': true,

      // Profile
      'photoUrl': '',

      // Ranking
      'recentRank': 0,
      'overallRank': 0,
      'batchRank': 0,
      'averageScore': 0,

      // Attendance
      'presentCount': 0,
      'absentCount': 0,

      // Fees
      'totalPaid': 0.0,
      'pendingFees': 0.0,

      // Status
      'active': true,

      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
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
  }) async {
    await _firestore.collection('students').doc(studentId).update({
      'name': name,
      'email': email,
      'phone': phone,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'parentEmail': parentEmail,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> assignBatch({
    required String studentId,
    required String batchId,
    required String batchName,
    required String teacherId,
    required String teacherName,
  }) async {
    await _firestore.collection('students').doc(studentId).update({
      'batchId': batchId,
      'batchName': batchName,

      'assignedTeacherId': teacherId,
      'assignedTeacherName': teacherName,

      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> updatePreferredLanguage({
    required String studentId,
    required String languageCode,
  }) async {
    await _firestore.collection('students').doc(studentId).update({
      'preferredLanguage': languageCode,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> deleteStudent(String docId) async {
    await _firestore.collection('students').doc(docId).delete();
  }
}
