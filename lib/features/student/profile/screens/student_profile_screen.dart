import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  Future<Map<String, dynamic>?> loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    return doc.data();
  }

  Widget infoTile(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value.isEmpty ? 'Not Available' : value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: loadProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Profile Not Found'));
          }

          final data = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),

              const SizedBox(height: 20),

              infoTile('Name', data['fullName'] ?? data['name'] ?? ''),

              infoTile('Email', data['email'] ?? ''),

              infoTile('Phone', data['phoneNumber'] ?? data['phone'] ?? ''),

              infoTile('Class', data['studentClass'] ?? ''),

              infoTile('Father Name', data['fatherName'] ?? ''),

              infoTile('Father Mobile', data['fatherMobile'] ?? ''),

              infoTile('Mother Name', data['motherName'] ?? ''),

              infoTile('Mother Mobile', data['motherMobile'] ?? ''),

              infoTile('Address', data['address'] ?? ''),

              infoTile('Admission Status', data['admissionStatus'] ?? ''),

              infoTile('Payment Status', data['paymentStatus'] ?? ''),

              infoTile(
                'Subscription',
                (data['subscriptionActive'] ?? false) ? 'Active' : 'Inactive',
              ),
            ],
          );
        },
      ),
    );
  }
}
