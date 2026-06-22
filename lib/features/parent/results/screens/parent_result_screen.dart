import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentResultScreen extends StatelessWidget {
  const ParentResultScreen({super.key});

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
      appBar: AppBar(title: const Text('Exam Results')),
      body: FutureBuilder<String?>(
        future: getStudentUid(),
        builder: (context, uidSnapshot) {
          if (!uidSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final studentUid = uidSnapshot.data;

          if (studentUid == null || studentUid.isEmpty) {
            return const Center(child: Text('Student Not Linked Yet'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('results')
                .where('studentId', isEqualTo: studentUid)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data?.docs ?? [];

              if (docs.isEmpty) {
                return const Center(child: Text('No Results Found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;

                  return Card(
                    child: ExpansionTile(
                      title: Text(data['examName'] ?? ''),
                      subtitle: Text('${data['percentage']}%'),
                      children: [
                        ListTile(
                          title: const Text('Math'),
                          trailing: Text('${data['math']}'),
                        ),
                        ListTile(
                          title: const Text('Science'),
                          trailing: Text('${data['science']}'),
                        ),
                        ListTile(
                          title: const Text('English'),
                          trailing: Text('${data['english']}'),
                        ),
                        ListTile(
                          title: const Text('Total'),
                          trailing: Text('${data['total']}'),
                        ),
                        ListTile(
                          title: const Text('Status'),
                          trailing: Text('${data['status']}'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
