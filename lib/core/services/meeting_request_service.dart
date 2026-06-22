import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingRequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitMeetingRequest({
    required String parentUid,
    required String parentName,
    required String studentUid,
    required String purpose,
  }) async {
    final now = Timestamp.now();

    await _firestore.collection('meeting_requests').add({
      'parentUid': parentUid,
      'parentName': parentName,
      'studentUid': studentUid,

      'purpose': purpose,

      'status': 'pending',

      'createdAt': now,
      'updatedAt': now,
    });
  }

  Stream<QuerySnapshot> getMeetingRequests() {
    return _firestore
        .collection('meeting_requests')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateStatus(String requestId, String status) async {
    await _firestore.collection('meeting_requests').doc(requestId).update({
      'status': status,
      'updatedAt': Timestamp.now(),
    });
  }
}
