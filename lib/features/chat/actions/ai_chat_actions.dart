import 'package:flutter/material.dart';

import 'package:digividya/features/chat/controllers/ai_chat_controller.dart';
import 'package:digividya/features/chat/models/ai_chat_message.dart';

import 'package:digividya/features/chat/services/export/chat_export_pdf_service.dart';
import 'package:digividya/features/chat/services/export/chat_export_word_service.dart';

class AiChatActions {
  static Future<void> clearChat({
    required BuildContext context,
    required AiChatController controller,
  }) async {
    await controller.clearChat();

    if (!context.mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Chat cleared successfully')));
  }

  static Future<void> exportPdf(List<AiChatMessage> messages) async {
    if (messages.isEmpty) return;

    await ChatExportPdfService.export(messages);
  }

  static Future<void> exportWord(List<AiChatMessage> messages) async {
    if (messages.isEmpty) return;

    await ChatExportWordService.export(messages);
  }
}
