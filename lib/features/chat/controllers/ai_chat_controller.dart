import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/chat/models/ai_chat_message.dart';
import 'package:digividya/features/chat/services/ai_chat_service.dart';
import 'package:digividya/features/chat/services/ai_chat_manager.dart';

class AiChatController {
  final AiChatService _chatService = AiChatService();

  final AiChatManager _chatManager = AiChatManager();

  String userRole = 'student';
  String userId = '';

  bool initialized = false;

  Future<void> loadUserRole() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    userId = user.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return;

    userRole = doc.data()?['role'] ?? 'student';

    initialized = true;
  }

  Stream<List<AiChatMessage>> getMessages() {
    if (userId.isEmpty) {
      return const Stream.empty();
    }

    return _chatService.getMessages(userId);
  }

  Future<String> sendMessage({
    required String message,
    required String language,
  }) {
    return _chatManager.sendMessage(
      userId: userId,
      userRole: userRole,
      message: message,
      language: language,
    );
  }

  Future<String> regenerateResponse({
    required String originalPrompt,
    required String language,
    required String parentMessageId,
  }) {
    return _chatManager.regenerateResponse(
      userId: userId,
      userRole: userRole,
      originalPrompt: originalPrompt,
      language: language,
      parentMessageId: parentMessageId,
    );
  }

  Future<void> clearChat() {
    return _chatManager.clearChat(userId);
  }
}
