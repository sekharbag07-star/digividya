import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveRequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitLeaveRequest({
    required String parentUid,
    required String parentName,
    required String studentUid,
    required String reason,
  }) async {
    final now = Timestamp.now();

    await _firestore.collection('leave_requests').add({
      'parentUid': parentUid,
      'parentName': parentName,
      'studentUid': studentUid,

      'reason': reason,

      'status': 'pending',

      'createdAt': now,
      'updatedAt': now,
    });
  }

  Stream<QuerySnapshot> getLeaveRequests() {
    return _firestore
        .collection('leave_requests')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateStatus(String requestId, String status) async {
    await _firestore.collection('leave_requests').doc(requestId).update({
      'status': status,
      'updatedAt': Timestamp.now(),
    });
  }
}
