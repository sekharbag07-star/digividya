import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfileScreen extends StatelessWidget {
  final String studentId;

  const StudentProfileScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Profile")),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final student = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),

                const SizedBox(height: 16),

                Text(
                  student['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(student['email'] ?? ''),

                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("Student Phone"),
                    subtitle: Text(student['phone'] ?? ''),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.family_restroom),
                    title: const Text("Parent Name"),
                    subtitle: Text(student['parentName'] ?? ''),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text("Parent Phone"),
                    subtitle: Text(student['parentPhone'] ?? ''),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text("Parent Email"),
                    subtitle: Text(student['parentEmail'] ?? ''),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.groups),
                    title: const Text("Batch"),
                    subtitle: Text(student['batch'] ?? ''),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Attendance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Card(
                  child: ListTile(
                    title: Text("Present: ${student['presentCount'] ?? 0}"),
                    subtitle: Text("Absent: ${student['absentCount'] ?? 0}"),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Fee Summary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Card(
                  child: ListTile(
                    title: Text("Paid: ₹${student['totalPaid'] ?? 0}"),
                    subtitle: Text("Pending: ₹${student['pendingFees'] ?? 0}"),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Rankings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Recent Rank"),
                        trailing: Text("#${student['recentRank'] ?? 0}"),
                      ),
                      ListTile(
                        title: const Text("Overall Rank"),
                        trailing: Text("#${student['overallRank'] ?? 0}"),
                      ),
                      ListTile(
                        title: const Text("Batch Rank"),
                        trailing: Text("#${student['batchRank'] ?? 0}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
