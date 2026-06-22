import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentAttendanceScreen extends StatelessWidget {
  const ParentAttendanceScreen({super.key});

  Future<String?> getStudentUid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final parentDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!parentDoc.exists) return null;

    return parentDoc.data()?['studentUid'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Child Attendance')),
      body: FutureBuilder<String?>(
        future: getStudentUid(),
        builder: (context, uidSnapshot) {
          if (uidSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final studentUid = uidSnapshot.data;

          if (studentUid == null || studentUid.isEmpty) {
            return const Center(child: Text('Student Not Linked Yet'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('attendance')
                .where('studentUid', isEqualTo: studentUid)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data?.docs ?? [];

              if (docs.isEmpty) {
                return const Center(child: Text('No Attendance Records Found'));
              }

              int present = 0;
              int absent = 0;

              for (final doc in docs) {
                final status = doc['status'].toString().toLowerCase();

                if (status == 'present') {
                  present++;
                } else {
                  absent++;
                }
              }

              final total = present + absent;

              final percentage = total == 0
                  ? 0
                  : ((present / total) * 100).toStringAsFixed(1);

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.calendar_month),
                        title: const Text('Attendance Percentage'),
                        subtitle: Text('$percentage%'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Card(
                      child: ListTile(
                        title: Text('Present: $present'),
                        subtitle: Text('Absent: $absent'),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final data =
                              docs[index].data() as Map<String, dynamic>;

                          final status = data['status'] ?? '';

                          final date = data['date'] ?? '';

                          return Card(
                            child: ListTile(
                              leading: Icon(
                                status.toString().toLowerCase() == 'present'
                                    ? Icons.check_circle
                                    : Icons.cancel,
                              ),
                              title: Text(status),
                              subtitle: Text(date),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
