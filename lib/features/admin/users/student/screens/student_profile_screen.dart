import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

          if (!snapshot.data!.exists) {
            return const Center(child: Text("Student not found"));
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

                const SizedBox(height: 4),

                Text(
                  student['email'] ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("Student Phone"),
                    subtitle: Text(student['phone'] ?? 'N/A'),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.family_restroom),
                    title: const Text("Parent Name"),
                    subtitle: Text(student['parentName'] ?? 'N/A'),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text("Parent Phone"),
                    subtitle: Text(student['parentPhone'] ?? 'N/A'),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text("Parent Email"),
                    subtitle: Text(student['parentEmail'] ?? 'N/A'),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.groups),
                    title: const Text("Batch"),
                    subtitle: Text(student['batchName'] ?? 'Not Assigned'),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Attendance Summary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.fact_check),
                    title: Text("Present : ${student['presentCount'] ?? 0}"),
                    subtitle: Text("Absent : ${student['absentCount'] ?? 0}"),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Fee Summary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.currency_rupee),
                    title: Text("Paid : ₹${student['totalPaid'] ?? 0}"),
                    subtitle: Text("Pending : ₹${student['pendingFees'] ?? 0}"),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Ranking & Performance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.emoji_events),
                        title: const Text("Recent Rank"),
                        trailing: Text("#${student['recentRank'] ?? 0}"),
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(Icons.workspace_premium),
                        title: const Text("Overall Rank"),
                        trailing: Text("#${student['overallRank'] ?? 0}"),
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(Icons.groups),
                        title: const Text("Batch Rank"),
                        trailing: Text("#${student['batchRank'] ?? 0}"),
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(Icons.analytics),
                        title: const Text("Average Score"),
                        trailing: Text(
                          "${((student['averageScore'] ?? 0) as num).toStringAsFixed(2)}%",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Recent Results",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('results')
                      .where('studentId', isEqualTo: studentId)
                      .orderBy('createdAt', descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context, resultSnapshot) {
                    if (!resultSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final results = resultSnapshot.data!.docs;

                    if (results.isEmpty) {
                      return const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("No Results Available"),
                        ),
                      );
                    }

                    return Column(
                      children: results.map((doc) {
                        final result = doc.data() as Map<String, dynamic>;

                        return Card(
                          child: ListTile(
                            leading: Icon(
                              result['status'] == 'Pass'
                                  ? Icons.check_circle
                                  : Icons.cancel,
                            ),
                            title: Text(result['examName'] ?? ''),
                            subtitle: Text(
                              "Total: ${result['total'] ?? 0} | Percentage: ${((result['percentage'] ?? 0) as num).toStringAsFixed(2)}%",
                            ),
                            trailing: Text(result['status'] ?? ''),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}





