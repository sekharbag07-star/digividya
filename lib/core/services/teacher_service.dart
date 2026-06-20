import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTeacher({
    required String name,
    required String email,
    required String phone,
    required String subject,
  }) async {
    await _firestore.collection('teachers').add({
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'active': true,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTeachers() {
    return _firestore
        .collection('teachers')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteTeacher(String docId) async {
    await _firestore.collection('teachers').doc(docId).delete();
  }
}



