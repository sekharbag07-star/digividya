import 'package:cloud_firestore/cloud_firestore.dart';

class AiChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveMessage({
    required String uid,
    required String role,
    required String originalText,
    required String translatedText,
    required String languageCode,
  }) async {
    await _firestore
        .collection('ai_chats')
        .doc(uid)
        .collection('messages')
        .add({
          'role': role,
          'originalText': originalText,
          'translatedText': translatedText,
          'languageCode': languageCode,
          'createdAt': Timestamp.now(),
        });
  }

  Stream<QuerySnapshot> getMessages(String uid) {
    return _firestore
        .collection('ai_chats')
        .doc(uid)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }
}
