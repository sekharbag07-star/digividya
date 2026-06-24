import 'package:flutter/material.dart';
import 'package:digividya/core/services/gemini_service.dart';

import '../widgets/ai_message_bubble.dart';
import '../widgets/ai_welcome_screen.dart';
import '../widgets/ai_loading_widget.dart';
import '../widgets/ai_language_selector.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final GeminiService _geminiService = GeminiService();

  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [];

  bool isLoading = false;

  String selectedLanguage = 'en';
  String userRole = 'student';
  final Map<String, String> languageNames = {
    'en': 'English',
    'hi': 'हिन्दी',
    'bn': 'বাংলা',
    'ta': 'தமிழ்',
    'te': 'తెలుగు',
    'mr': 'मराठी',
    'gu': 'ગુજરાતી',
    'kn': 'ಕನ್ನಡ',
    'ml': 'മലയാളം',
    'pa': 'ਪੰਜਾਬੀ',
    'ur': 'اردو',
    'or': 'ଓଡ଼ିଆ',
  };

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty || isLoading) return;

    setState(() {
      messages.add({'role': 'user', 'message': text});

      isLoading = true;
    });

    messageController.clear();

    try {
      final aiResponse = await _geminiService.generateResponse(
        message: text,
        language: selectedLanguage,
        role: userRole,
      );

      if (!mounted) return;

      setState(() {
        messages.add({'role': 'ai', 'message': aiResponse});
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add({'role': 'ai', 'message': 'DigiVidya AI Error:\n$e'});
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/logo/digividya_logo.png',
                height: 30,
                width: 30,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.school, size: 28);
                },
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(child: Text('DigiVidya AI')),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                languageNames[selectedLanguage] ?? 'English',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          AiLanguageSelector(
            onSelected: (value) {
              setState(() {
                selectedLanguage = value;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Language changed to ${languageNames[value]}'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade50,
            child: Text(
              'Current Language: ${languageNames[selectedLanguage]}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: messages.isEmpty
                ? const AiWelcomeScreen()
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];

                      return AiMessageBubble(
                        message: msg['message'],
                        isUser: msg['role'] == 'user',
                      );
                    },
                  ),
          ),

          if (isLoading) const AiLoadingWidget(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Ask DigiVidya AI...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),

                  const SizedBox(width: 10),

                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: isLoading ? null : sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
