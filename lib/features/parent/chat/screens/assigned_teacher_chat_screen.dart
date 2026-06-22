import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/chat/screens/chat_detail_screen.dart';

class AssignedTeacherChatScreen extends StatelessWidget {
  const AssignedTeacherChatScreen({super.key});

  Future<DocumentSnapshot?> getStudentRecord(String parentUid) async {
    final result = await FirebaseFirestore.instance
        .collection('students')
        .where('parentUid', isEqualTo: parentUid)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      return null;
    }

    return result.docs.first;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Please login again')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Assigned Teacher')),
      body: FutureBuilder<DocumentSnapshot?>(
        future: getStudentRecord(currentUser.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text('No student linked with this parent account'),
            );
          }

          final student = snapshot.data!.data() as Map<String, dynamic>;

          final teacherId = student['assignedTeacherId'] ?? '';

          final teacherName = student['assignedTeacherName'] ?? '';

          if (teacherId.toString().isEmpty) {
            return const Center(child: Text('No teacher assigned yet'));
          }

          final chatId = '${currentUser.uid}_$teacherId';

          return Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: Text('Open Chat With $teacherName'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatDetailScreen(
                      chatId: chatId,
                      currentUserId: currentUser.uid,
                      currentUserRole: 'parent',
                      receiverId: teacherId,
                      receiverName: teacherName,
                      chatType: 'assigned_teacher',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
