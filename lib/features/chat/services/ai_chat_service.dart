import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/features/chat/models/ai_chat_message.dart';

class AiChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _messagesRef(String userId) {
    return _firestore.collection('ai_chats').doc(userId).collection('messages');
  }

  Future<String> saveMessage({
    required String userId,
    required String role,
    required String message,
    String? parentMessageId,
  }) async {
    final doc = await _messagesRef(userId).add({
      'role': role,
      'message': message,
      'createdAt': Timestamp.now(),
      'parentMessageId': parentMessageId,
    });

    return doc.id;
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

  Future<AiChatMessage?> getMessageById({
    required String userId,
    required String messageId,
  }) async {
    final doc = await _messagesRef(userId).doc(messageId).get();

    if (!doc.exists) {
      return null;
    }

    return AiChatMessage.fromFirestore(doc);
  }

  Future<String> getConversationHistory({
    required String userId,
    int limit = 1000,
  }) async {
    final snapshot = await _messagesRef(
      userId,
    ).orderBy('createdAt', descending: true).limit(limit).get();

    final messages = snapshot.docs.reversed;

    final buffer = StringBuffer();

    for (final doc in messages) {
      final data = doc.data();

      final role = data['role'] ?? 'user';
      final message = data['message'] ?? '';

      buffer.writeln('$role: $message');
    }

    return buffer.toString();
  }
}
