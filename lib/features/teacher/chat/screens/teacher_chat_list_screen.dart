import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/chat/screens/chat_detail_screen.dart';

class TeacherChatListScreen extends StatelessWidget {
  const TeacherChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherUid = FirebaseAuth.instance.currentUser?.uid;

    if (teacherUid == null) {
      return const Scaffold(body: Center(child: Text('Teacher not logged in')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Parent Chats')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('teacherUid', isEqualTo: teacherUid)
            .where('chatType', isEqualTo: 'teacher')
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Parent Chats Available'));
          }

          final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final data = chats[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.family_restroom),
                  ),
                  title: Text(data['parentName'] ?? 'Parent'),
                  subtitle: Text(
                    data['lastMessage'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(
                          chatId: chats[index].id,
                          currentUserId: teacherUid,
                          currentUserRole: 'teacher',
                          receiverId: data['parentUid'] ?? '',
                          receiverName: data['parentName'] ?? 'Parent',
                          chatType: 'teacher',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
