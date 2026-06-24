import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AiMessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const AiMessageBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  Future<void> _copyMessage(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: message));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _copyMessage(context),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: const TextStyle(fontSize: 14)),

              const SizedBox(height: 6),

              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.copy_outlined,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
