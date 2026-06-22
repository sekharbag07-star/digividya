import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentResultScreen extends StatelessWidget {
  const StudentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("My Results")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('results')
            .where('studentId', isEqualTo: uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text("No Results Available"));
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
      ),
    );
  }
}
