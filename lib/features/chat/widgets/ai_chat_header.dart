import 'package:flutter/material.dart';

import 'ai_role_badge.dart';

class AiChatHeader extends StatelessWidget {
  final String role;
  final VoidCallback onClearChat;

  const AiChatHeader({
    super.key,
    required this.role,
    required this.onClearChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          AiRoleBadge(role: role),

          const Spacer(),

          IconButton(
            tooltip: 'Clear Chat',
            icon: const Icon(Icons.delete_outline),
            onPressed: onClearChat,
          ),
        ],
      ),
    );
  }
}
