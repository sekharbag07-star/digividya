import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'student_profile_screen.dart';

class StudentDirectoryScreen extends StatelessWidget {
  const StudentDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Directory')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load students'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data?.docs ?? [];

          if (students.isEmpty) {
            return const Center(child: Text('No students found'));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];

              final data = student.data() as Map<String, dynamic>;

              final name = data['name']?.toString() ?? 'Unknown Student';

              final phone = data['phone']?.toString() ?? '';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(name),
                  subtitle: Text(phone),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            StudentProfileScreen(studentId: student.id),
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
