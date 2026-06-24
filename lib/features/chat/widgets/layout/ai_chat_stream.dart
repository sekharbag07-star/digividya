import 'package:flutter/material.dart';

import 'package:digividya/features/chat/controllers/ai_chat_controller.dart';
import 'package:digividya/features/chat/models/ai_chat_message.dart';
import 'package:digividya/features/chat/widgets/common/ai_message_bubble.dart';
import 'package:digividya/features/chat/widgets/common/ai_welcome_screen.dart';

class AiChatStream extends StatefulWidget {
  final AiChatController controller;

  const AiChatStream({super.key, required this.controller});

  @override
  State<AiChatStream> createState() => _AiChatStreamState();
}

class _AiChatStreamState extends State<AiChatStream> {
  final ScrollController _scrollController = ScrollController();

  bool _isRegenerating = false;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _toggleFavorite(AiChatMessage message) async {
    try {
      await widget.controller.toggleFavorite(
        messageId: message.id,
        isFavorite: !message.isFavorite,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Favorite update failed: $e')));
    }
  }

  Future<void> _regenerateMessage(AiChatMessage aiMessage) async {
    if (_isRegenerating) {
      return;
    }

    if (aiMessage.parentMessageId == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Original prompt not found')),
      );
      return;
    }

    try {
      setState(() {
        _isRegenerating = true;
      });

      final originalMessage = await widget.controller.getMessageById(
        aiMessage.parentMessageId!,
      );

      if (originalMessage == null) {
        throw Exception('Original message not found');
      }

      await widget.controller.regenerateResponse(
        originalPrompt: originalMessage.message,
        language: 'en',
        parentMessageId: originalMessage.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Response regenerated')));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Regenerate failed: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isRegenerating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AiChatMessage>>(
      stream: widget.controller.getMessages(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data ?? [];

        if (messages.isNotEmpty) {
          _scrollToBottom();
        }

        if (messages.isEmpty) {
          return const AiWelcomeScreen();
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];

            return AiMessageBubble(
              message: msg.message,
              isUser: msg.role == 'user',
              createdAt: msg.createdAt.toDate(),
              isFavorite: msg.isFavorite,
              onFavoriteToggle: () => _toggleFavorite(msg),
              onRegenerate: msg.role == 'ai'
                  ? () => _regenerateMessage(msg)
                  : null,
            );
          },
        );
      },
    );
  }
}
