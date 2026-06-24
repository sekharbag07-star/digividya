import 'package:flutter/material.dart';

import 'package:digividya/features/chat/controllers/ai_chat_controller.dart';
import 'package:digividya/features/chat/models/ai_chat_message.dart';
import 'package:digividya/features/chat/widgets/common/ai_message_bubble.dart';
import 'package:digividya/features/chat/widgets/common/ai_welcome_screen.dart';

class AiChatStream extends StatelessWidget {
  final AiChatController controller;

  const AiChatStream({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AiChatMessage>>(
      stream: controller.getMessages(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data ?? [];

        if (messages.isEmpty) {
          return const AiWelcomeScreen();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];

            return AiMessageBubble(
              message: msg.message,
              isUser: msg.role == 'user',
            );
          },
        );
      },
    );
  }
}
