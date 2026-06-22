import 'package:flutter/material.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [];

  String selectedLanguage = 'en';

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

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'message': text});

      messages.add({
        'role': 'ai',
        'message':
            'DigiVidya AI is under development.\n\nSelected Language: ${languageNames[selectedLanguage]}\n\nGemini/OpenAI integration will be connected in next phase.',
      });
    });

    messageController.clear();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Widget buildMessage(Map<String, dynamic> msg) {
    final isUser = msg['role'] == 'user';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(msg['message'], style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  PopupMenuButton<String> languageSelector() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: 'Change Language',
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
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'en', child: Text('English')),
        PopupMenuItem(value: 'hi', child: Text('हिन्दी')),
        PopupMenuItem(value: 'bn', child: Text('বাংলা')),
        PopupMenuItem(value: 'ta', child: Text('தமிழ்')),
        PopupMenuItem(value: 'te', child: Text('తెలుగు')),
        PopupMenuItem(value: 'mr', child: Text('मराठी')),
        PopupMenuItem(value: 'gu', child: Text('ગુજરાતી')),
        PopupMenuItem(value: 'kn', child: Text('ಕನ್ನಡ')),
        PopupMenuItem(value: 'ml', child: Text('മലയാളം')),
        PopupMenuItem(value: 'pa', child: Text('ਪੰਜਾਬੀ')),
        PopupMenuItem(value: 'ur', child: Text('اردو')),
        PopupMenuItem(value: 'or', child: Text('ଓଡ଼ିଆ')),
      ],
    );
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
          languageSelector(),
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
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo/digividya_logo.png',
                            height: 80,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.school, size: 80);
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Welcome to DigiVidya AI',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Homework Help\nExam Preparation\nAttendance Queries\nFee Queries\nNotice Summary\nParent Guidance\nTeacher Assistant',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return buildMessage(messages[index]);
                    },
                  ),
          ),

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
                    onPressed: sendMessage,
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
