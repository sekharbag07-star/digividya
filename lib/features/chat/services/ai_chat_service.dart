import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ai_chat_message.dart';

class AiChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _messagesRef(String userId) {
    return _firestore.collection('ai_chats').doc(userId).collection('messages');
  }

  Future<void> saveMessage({
    required String userId,
    required String role,
    required String message,
  }) async {
    await _messagesRef(
      userId,
    ).add({'role': role, 'message': message, 'createdAt': Timestamp.now()});
  }

  Stream<List<AiChatMessage>> getMessages(String userId) {
    return _messagesRef(userId)
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AiChatMessage.fromFirestore(doc))
              .toList(),
        );
  }

  Future<void> clearChat(String userId) async {
    final snapshot = await _messagesRef(userId).get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
