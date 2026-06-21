import 'package:cloud_firestore/cloud_firestore.dart';

class FeeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFee({
    required String studentName,
    required double amount,
    required String month,
    required String status,
  }) async {
    await _firestore.collection('fees').add({
      'studentName': studentName,
      'amount': amount,
      'month': month,
      'status': status,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getFees() {
    return _firestore
        .collection('fees')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}





