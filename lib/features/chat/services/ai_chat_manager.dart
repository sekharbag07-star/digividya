import 'package:digividya/core/services/gemini_service.dart';

import 'package:digividya/features/chat/helpers/ai_prompt_builder.dart';
import 'package:digividya/features/chat/services/ai_chat_service.dart';

class AiChatManager {
  final GeminiService _geminiService = GeminiService();
  final AiChatService _chatService = AiChatService();

  Future<String> sendMessage({
    required String userId,
    required String userRole,
    required String message,
    required String language,
  }) async {
    final userMessageId = await _chatService.saveMessage(
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
      parentMessageId: userMessageId,
    );

    return aiResponse;
  }

  Future<String> regenerateResponse({
    required String userId,
    required String userRole,
    required String originalPrompt,
    required String language,
    required String parentMessageId,
  }) async {
    final prompt = AiPromptBuilder.build(
      role: userRole,
      language: language,
      message: originalPrompt,
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
      parentMessageId: parentMessageId,
    );

    return aiResponse;
  }

  Future<void> clearChat(String userId) {
    return _chatService.clearChat(userId);
  }
}
