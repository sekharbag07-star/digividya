import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitComplaint({
    required String parentUid,
    required String parentName,
    required String complaint,
  }) async {
    final now = Timestamp.now();

    await _firestore.collection('complaints').add({
      'parentUid': parentUid,
      'parentName': parentName,
      'complaint': complaint,

      // Status
      'status': 'pending',

      // Admin Response
      'adminRemark': '',

      // Audit
      'createdAt': now,
      'updatedAt': now,

      // Resolution
      'resolvedAt': null,
      'resolvedBy': '',

      // Rejection
      'rejectedAt': null,
      'rejectedBy': '',
    });
  }

  Stream<QuerySnapshot> getComplaints() {
    return _firestore
        .collection('complaints')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getParentComplaints(String parentUid) {
    return _firestore
        .collection('complaints')
        .where('parentUid', isEqualTo: parentUid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> resolveComplaint(
    String complaintId, {
    String adminRemark = '',
    String resolvedBy = '',
  }) async {
    await _firestore.collection('complaints').doc(complaintId).update({
      'status': 'resolved',
      'adminRemark': adminRemark,
      'resolvedBy': resolvedBy,
      'resolvedAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> rejectComplaint(
    String complaintId, {
    String adminRemark = '',
    String rejectedBy = '',
  }) async {
    await _firestore.collection('complaints').doc(complaintId).update({
      'status': 'rejected',
      'adminRemark': adminRemark,
      'rejectedBy': rejectedBy,
      'rejectedAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> updateStatus(String complaintId, String status) async {
    await _firestore.collection('complaints').doc(complaintId).update({
      'status': status,
      'updatedAt': Timestamp.now(),
    });
  }
}
