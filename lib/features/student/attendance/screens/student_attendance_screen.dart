import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('attendance')
            .where('studentUid', isEqualTo: uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No Attendance Records'));
          }

          int present = 0;
          int absent = 0;

          for (final doc in docs) {
            final data = doc.data() as Map<String, dynamic>;

            if ((data['status'] ?? '').toString().toLowerCase() == 'present') {
              present++;
            } else {
              absent++;
            }
          }

          final total = present + absent;

          final percentage = total == 0
              ? 0
              : ((present / total) * 100).toStringAsFixed(1);

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: ListTile(
                  leading: const Icon(Icons.fact_check),
                  title: Text('Attendance: $percentage%'),
                  subtitle: Text('Present: $present | Absent: $absent'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          data['status'] == 'Present'
                              ? Icons.check_circle
                              : Icons.cancel,
                        ),
                        title: Text(data['status']),
                        subtitle: Text(data['date']),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
