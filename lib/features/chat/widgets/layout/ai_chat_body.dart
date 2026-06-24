import 'package:flutter/material.dart';

import 'package:digividya/features/chat/controllers/ai_chat_controller.dart';
import 'package:digividya/features/chat/widgets/common/ai_loading_widget.dart';
import 'package:digividya/features/chat/widgets/input/ai_chat_input.dart';
import 'package:digividya/features/chat/widgets/layout/ai_chat_stream.dart';

class AiChatBody extends StatelessWidget {
  final AiChatController controller;

  final TextEditingController messageController;

  final bool isLoading;

  final Future<void> Function() onSend;

  const AiChatBody({
    super.key,
    required this.controller,
    required this.messageController,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: AiChatStream(controller: controller)),

        if (isLoading) const AiLoadingWidget(),

        AiChatInput(
          controller: messageController,
          isLoading: isLoading,
          onSend: onSend,
        ),
      ],
    );
  }
}
