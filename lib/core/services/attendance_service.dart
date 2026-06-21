import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> markAttendance({
    required String studentName,
    required String status,
  }) async {
    await _firestore.collection('attendance').add({
      'studentName': studentName,
      'status': status,
      'date': DateTime.now().toString().split(' ')[0],
      'createdAt': Timestamp.now(),
    });
  }
}







