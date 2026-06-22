import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentFeeScreen extends StatelessWidget {
  const ParentFeeScreen({super.key});

  Future<String?> getStudentUid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final parentDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    return parentDoc.data()?['studentUid'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fee Details')),
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
                .collection('fees')
                .where('studentUid', isEqualTo: studentUid)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data?.docs ?? [];

              if (docs.isEmpty) {
                return const Center(child: Text('No Fee Records Found'));
              }

              double total = 0;
              double paid = 0;
              double pending = 0;

              for (final doc in docs) {
                final data = doc.data() as Map<String, dynamic>;

                final amount = (data['amount'] ?? 0).toDouble();

                total += amount;

                if (data['status'] == 'paid') {
                  paid += amount;
                } else {
                  pending += amount;
                }
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Total Fees'),
                      subtitle: Text('₹$total'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: const Text('Paid'),
                      subtitle: Text('₹$paid'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: const Text('Pending'),
                      subtitle: Text('₹$pending'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      child: ListTile(
                        title: Text(data['month'] ?? ''),
                        subtitle: Text('₹${data['amount']}'),
                        trailing: Text(data['status'] ?? ''),
                      ),
                    );
                  }),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
