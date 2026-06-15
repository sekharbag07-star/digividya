import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> markAttendance(
    String studentId,
    String studentName,
    String batchName,
    String status,
  ) async {
    try {
      final today = DateTime.now().toString().split(' ')[0];

      final attendanceId = '${studentId}_$today';

      final attendanceDoc = await firestore
          .collection('attendance')
          .doc(attendanceId)
          .get();

      if (attendanceDoc.exists) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$studentName attendance already marked today'),
          ),
        );
        return;
      }

      await firestore.collection('attendance').doc(attendanceId).set({
        'studentId': studentId,
        'studentName': studentName,
        'batchName': batchName,
        'status': status,
        'date': today,
        'createdAt': Timestamp.now(),
      });

      final studentRef = firestore.collection('students').doc(studentId);

      if (status == 'Present') {
        await studentRef.update({'presentCount': FieldValue.increment(1)});
      } else {
        await studentRef.update({'absentCount': FieldValue.increment(1)});
      }

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$studentName marked $status')));
    } catch (e) {
      debugPrint('Attendance Error: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Management'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data?.docs ?? [];

          if (students.isEmpty) {
            return const Center(
              child: Text('No Students Found', style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];

              final data = student.data() as Map<String, dynamic>? ?? {};

              final name = data['name']?.toString() ?? 'Unknown Student';

              final batch =
                  data['batchName']?.toString() ??
                  data['batch']?.toString() ??
                  'Not Assigned';

              final presentCount = data['presentCount'] ?? 0;
              final absentCount = data['absentCount'] ?? 0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.school)),
                  title: Text(name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Batch: $batch'),
                      Text('Present: $presentCount | Absent: $absentCount'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          markAttendance(student.id, name, batch, 'Present');
                        },
                        child: const Text('P'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          markAttendance(student.id, name, batch, 'Absent');
                        },
                        child: const Text('A'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
