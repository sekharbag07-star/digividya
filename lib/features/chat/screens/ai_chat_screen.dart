import 'package:flutter/material.dart';

import 'package:digividya/features/chat/controllers/ai_chat_controller.dart';
import 'package:digividya/features/chat/widgets/layout/ai_chat_header.dart';
import 'package:digividya/features/chat/widgets/layout/ai_chat_stream.dart';
import 'package:digividya/features/chat/widgets/input/ai_chat_input.dart';
import 'package:digividya/features/chat/widgets/common/ai_loading_widget.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final AiChatController _controller = AiChatController();

  final TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  String selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _controller.loadUserRole();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty || isLoading) return;

    setState(() {
      isLoading = true;
    });

    messageController.clear();

    try {
      await _controller.sendMessage(message: text, language: selectedLanguage);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('DigiVidya AI Error:\n$e')));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> clearChat() async {
    await _controller.clearChat();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Chat cleared successfully')));
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AiChatHeader(
        selectedLanguage: selectedLanguage,
        role: _controller.userRole,
        onLanguageChanged: (value) {
          setState(() {
            selectedLanguage = value;
          });
        },
        onClearChat: clearChat,
      ),
      body: Column(
        children: [
          Expanded(child: AiChatStream(controller: _controller)),

          if (isLoading) const AiLoadingWidget(),

          AiChatInput(
            controller: messageController,
            isLoading: isLoading,
            onSend: sendMessage,
          ),
        ],
      ),
    );
  }
}
