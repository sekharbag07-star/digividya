import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitSuggestion({
    required String parentUid,
    required String parentName,
    required String suggestion,
  }) async {
    final now = Timestamp.now();

    await _firestore.collection('suggestions').add({
      'parentUid': parentUid,
      'parentName': parentName,
      'suggestion': suggestion,

      'status': 'pending',
      'adminRemark': '',

      'createdAt': now,
      'updatedAt': now,
    });
  }

  Stream<QuerySnapshot> getSuggestions() {
    return _firestore
        .collection('suggestions')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateStatus(String suggestionId, String status) async {
    await _firestore.collection('suggestions').doc(suggestionId).update({
      'status': status,
      'updatedAt': Timestamp.now(),
    });
  }
}
