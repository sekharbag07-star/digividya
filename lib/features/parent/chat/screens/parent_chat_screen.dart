import 'package:flutter/material.dart';

import 'package:digividya/features/parent/chat/screens/teacher_selection_screen.dart';
import 'package:digividya/features/support/screens/support_chat_screen.dart';
import 'package:digividya/features/chat/screens/ai_chat_screen.dart';
import 'package:digividya/features/parent/chat/screens/assigned_teacher_chat_screen.dart';

class ParentChatScreen extends StatelessWidget {
  const ParentChatScreen({super.key});

  void comingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$title Coming Soon')));
  }

  Widget chatCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Center')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            chatCard(
              context: context,
              title: 'Chat Any Teacher',
              subtitle: 'Select and chat with any teacher',
              icon: Icons.person,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TeacherSelectionScreen(),
                  ),
                );
              },
            ),

            chatCard(
              context: context,
              title: 'Assigned Teacher',
              subtitle: 'Chat with assigned teacher',
              icon: Icons.school,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AssignedTeacherChatScreen(),
                  ),
                );
              },
            ),

            chatCard(
              context: context,
              title: 'Institute Support',
              subtitle: 'Contact institute support team',
              icon: Icons.support_agent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupportChatScreen()),
                );
              },
            ),

            chatCard(
              context: context,
              title: 'DigiVidya AI Assistant',
              subtitle: 'AI powered guidance and help',
              icon: Icons.smart_toy,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AiChatScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
