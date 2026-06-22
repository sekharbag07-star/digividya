import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentFeeScreen extends StatelessWidget {
  const StudentFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Fees')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('fees')
            .where('studentUid', isEqualTo: uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No Fee Records'));
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
                    title: Text(data['month']),
                    subtitle: Text('₹${data['amount']}'),
                    trailing: Text(data['status']),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
