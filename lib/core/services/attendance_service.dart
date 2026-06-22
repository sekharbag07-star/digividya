import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> markAttendance({
    required String studentUid,
    required String studentName,
    required String status,
  }) async {
    await _firestore.collection('attendance').add({
      'studentUid': studentUid,
      'studentName': studentName,
      'status': status,

      'date': DateTime.now().toString().split(' ')[0],

      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getStudentAttendance(String studentUid) {
    return _firestore
        .collection('attendance')
        .where('studentUid', isEqualTo: studentUid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
