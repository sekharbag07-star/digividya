import 'package:flutter/material.dart';

import 'package:digividya/features/chat/actions/ai_chat_actions.dart';
import 'package:digividya/features/chat/controllers/ai_chat_controller.dart';
import 'package:digividya/features/chat/models/ai_chat_message.dart';
import 'package:digividya/features/chat/search/ai_chat_search_delegate.dart';

import 'package:digividya/features/chat/widgets/layout/ai_chat_body.dart';
import 'package:digividya/features/chat/widgets/layout/ai_chat_header.dart';

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

  List<AiChatMessage> currentMessages = [];

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

    if (text.isEmpty || isLoading) {
      return;
    }

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

  void _openSearch() {
    showSearch(
      context: context,
      delegate: AiChatSearchDelegate(messages: currentMessages),
    );
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

    return StreamBuilder<List<AiChatMessage>>(
      stream: _controller.getMessages(),
      builder: (context, snapshot) {
        currentMessages = snapshot.data ?? [];

        return Scaffold(
          appBar: AiChatHeader(
            selectedLanguage: selectedLanguage,
            role: _controller.userRole,

            onLanguageChanged: (value) {
              setState(() {
                selectedLanguage = value;
              });
            },

            onSearch: _openSearch,

            onClearChat: () => AiChatActions.clearChat(
              context: context,
              controller: _controller,
            ),

            onExportPdf: () => AiChatActions.exportPdf(currentMessages),

            onExportWord: () => AiChatActions.exportWord(currentMessages),
          ),

          body: AiChatBody(
            controller: _controller,
            messageController: messageController,
            isLoading: isLoading,
            onSend: sendMessage,
          ),
        );
      },
    );
  }
}
