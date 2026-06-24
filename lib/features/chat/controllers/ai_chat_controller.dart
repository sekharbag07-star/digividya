import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/chat/models/ai_chat_message.dart';
import 'package:digividya/features/chat/services/ai_chat_service.dart';
import 'package:digividya/features/chat/helpers/ai_prompt_builder.dart';
import 'package:digividya/core/services/gemini_service.dart';

class AiChatController {
  final GeminiService _geminiService = GeminiService();
  final AiChatService _chatService = AiChatService();

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
  }) async {
    await _chatService.saveMessage(
      userId: userId,
      role: 'user',
      message: message,
    );

    final prompt = AiPromptBuilder.build(
      role: userRole,
      language: language,
      message: message,
    );

    final aiResponse = await _geminiService.generateResponse(
      message: prompt,
      language: language,
      role: userRole,
    );

    await _chatService.saveMessage(
      userId: userId,
      role: 'ai',
      message: aiResponse,
    );

    return aiResponse;
  }

  Future<void> clearChat() async {
    await _chatService.clearChat(userId);
  }
}
