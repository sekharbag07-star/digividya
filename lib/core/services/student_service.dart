import 'package:cloud_firestore/cloud_firestore.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStudent({
    required String name,
    required String email,
    required String phone,
    required String batch,
  }) async {
    await _firestore.collection('students').add({
      'name': name,
      'email': email,
      'phone': phone,
      'batch': batch,
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

  Future<void> deleteStudent(String docId) async {
    await _firestore.collection('students').doc(docId).delete();
  }
}
