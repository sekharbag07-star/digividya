import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  Future<Map<String, dynamic>?> loadStudentData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final parentDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!parentDoc.exists) return null;

    final parentData = parentDoc.data()!;

    final studentUid = parentData['studentUid'];

    if (studentUid == null || studentUid.toString().isEmpty) {
      return null;
    }

    final studentDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(studentUid)
        .get();

    if (!studentDoc.exists) return null;

    return studentDoc.data();
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
      appBar: AppBar(title: const Text('Child Profile')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: loadStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Student Not Linked Yet',
                style: TextStyle(fontSize: 18),
              ),
            );
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

              infoTile('Student Name', data['fullName'] ?? data['name'] ?? ''),

              infoTile('Class', data['studentClass'] ?? ''),

              infoTile('Father Name', data['fatherName'] ?? ''),

              infoTile('Mother Name', data['motherName'] ?? ''),

              infoTile('Phone', data['phoneNumber'] ?? data['phone'] ?? ''),

              infoTile('Address', data['address'] ?? ''),

              infoTile('Admission Status', data['admissionStatus'] ?? ''),

              infoTile('Payment Status', data['paymentStatus'] ?? ''),
            ],
          );
        },
      ),
    );
  }
}
