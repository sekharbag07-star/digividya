import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;

  final String currentUserId;
  final String currentUserRole;

  final String receiverId;
  final String receiverName;

  final String chatType;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.currentUserId,
    required this.currentUserRole,
    required this.receiverId,
    required this.receiverName,
    required this.chatType,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController messageController = TextEditingController();

  bool isSending = false;

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    try {
      setState(() {
        isSending = true;
      });

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .add({
            'senderId': widget.currentUserId,
            'receiverId': widget.receiverId,
            'senderRole': widget.currentUserRole,
            'message': text,
            'isRead': false,
            'messageType': 'text',
            'createdAt': Timestamp.now(),
          });

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .set({
            'chatType': widget.chatType,
            'lastMessage': text,
            'lastMessageTime': Timestamp.now(),
          }, SetOptions(merge: true));

      messageController.clear();
    } finally {
      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    }
  }

  void openAiPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('DigiVidya AI Assistant integration coming soon'),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Widget buildMessageBubble(Map<String, dynamic> data) {
    final isMine = data['senderId'] == widget.currentUserId;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isMine ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(data['message'] ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messagesRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .orderBy('createdAt');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy),
            onPressed: openAiPlaceholder,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Center(child: Text('Start conversation...'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    return buildMessageBubble(data);
                  },
                );
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
                        hintText: 'Type message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  IconButton(
                    icon: isSending
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: isSending ? null : sendMessage,
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
