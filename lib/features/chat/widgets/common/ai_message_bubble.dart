import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AiMessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  final DateTime? createdAt;

  final bool isFavorite;

  final VoidCallback? onRegenerate;
  final VoidCallback? onFavoriteToggle;

  const AiMessageBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.createdAt,
    this.isFavorite = false,
    this.onRegenerate,
    this.onFavoriteToggle,
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

  String _formatTime() {
    if (createdAt == null) return '';

    final hour = createdAt!.hour > 12
        ? createdAt!.hour - 12
        : createdAt!.hour == 0
        ? 12
        : createdAt!.hour;

    final minute = createdAt!.minute.toString().padLeft(2, '0');

    final period = createdAt!.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            const Padding(
              padding: EdgeInsets.only(right: 8, top: 4),
              child: CircleAvatar(
                radius: 16,
                child: Icon(Icons.smart_toy, size: 18),
              ),
            ),

          Flexible(
            child: GestureDetector(
              onLongPress: () => _copyMessage(context),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
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

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTime(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: onFavoriteToggle,
                              child: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                size: 16,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Icon(
                              Icons.copy_outlined,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),

                            if (!isUser && onRegenerate != null) ...[
                              const SizedBox(width: 10),

                              GestureDetector(
                                onTap: onRegenerate,
                                child: Icon(
                                  Icons.refresh,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (isUser)
            const Padding(
              padding: EdgeInsets.only(left: 8, top: 4),
              child: CircleAvatar(
                radius: 16,
                child: Icon(Icons.person, size: 18),
              ),
            ),
        ],
      ),
    );
  }
}
