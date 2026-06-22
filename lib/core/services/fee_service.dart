import 'package:cloud_firestore/cloud_firestore.dart';

class FeeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFee({
    required String studentUid,
    required String studentName,
    required double amount,
    required String month,
    required String status,
  }) async {
    await _firestore.collection('fees').add({
      'studentUid': studentUid,
      'studentName': studentName,
      'amount': amount,
      'month': month,
      'status': status,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getStudentFees(String studentUid) {
    return _firestore
        .collection('fees')
        .where('studentUid', isEqualTo: studentUid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
