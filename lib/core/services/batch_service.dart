import 'package:cloud_firestore/cloud_firestore.dart';

class BatchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBatch({
    required String name,
    required String subject,
    required String teacher,
  }) async {
    await _firestore.collection('batches').add({
      'name': name,
      'subject': subject,
      'teacher': teacher,
      'active': true,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getBatches() {
    return _firestore
        .collection('batches')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteBatch(String docId) async {
    await _firestore.collection('batches').doc(docId).delete();
  }
}
