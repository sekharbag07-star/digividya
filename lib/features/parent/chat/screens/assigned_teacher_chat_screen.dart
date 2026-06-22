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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text('No student linked with this parent account'),
            );
          }

          final student = snapshot.data!.data() as Map<String, dynamic>;

          final teacherId = (student['assignedTeacherId'] ?? '').toString();

          final teacherName = (student['assignedTeacherName'] ?? '').toString();

          final studentName = (student['name'] ?? 'Student').toString();

          final batchName = (student['batchName'] ?? 'Not Assigned').toString();

          if (teacherId.isEmpty) {
            return const Center(child: Text('No teacher assigned yet'));
          }

          final chatId = '${currentUser.uid}_$teacherId';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      child: Icon(Icons.school, size: 35),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      teacherName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text('Student: $studentName'),

                    Text('Batch: $batchName'),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.chat),
                        label: const Text('Open Chat'),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
