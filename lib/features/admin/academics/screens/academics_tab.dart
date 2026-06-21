import 'package:flutter/material.dart';

import 'package:digividya/features/admin/academics/attendance/screens/attendance_screen.dart';
import 'package:digividya/features/admin/academics/batches/screens/batch_management_screen.dart';
import 'package:digividya/features/admin/academics/student_batch/screens/student_batch_screen.dart';
import 'package:digividya/features/admin/academics/exams/screens/exam_management_screen.dart';
import 'package:digividya/features/admin/academics/results/screens/result_entry_screen.dart';

class AcademicsTab extends StatelessWidget {
  const AcademicsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _tile(
          context,
          title: 'Attendance',
          icon: Icons.fact_check,
          screen: const AttendanceScreen(),
        ),
        _tile(
          context,
          title: 'Batch Management',
          icon: Icons.groups,
          screen: const BatchManagementScreen(),
        ),
        _tile(
          context,
          title: 'Student Batch Mapping',
          icon: Icons.group_work,
          screen: const StudentBatchScreen(),
        ),
        _tile(
          context,
          title: 'Exam Management',
          icon: Icons.quiz,
          screen: const ExamManagementScreen(),
        ),
        _tile(
          context,
          title: 'Result Entry',
          icon: Icons.workspace_premium,
          screen: const ResultEntryScreen(),
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}








