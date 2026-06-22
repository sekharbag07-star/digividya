import 'package:flutter/material.dart';

import 'package:digividya/features/admin/users/student/screens/student_directory_screen.dart';
import 'package:digividya/features/admin/users/student/screens/student_management_screen.dart';
import 'package:digividya/features/admin/users/teacher/screens/teacher_management_screen.dart';
import 'package:digividya/features/admin/users/parent_linking/screens/parent_student_link_screen.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _tile(
          context,
          title: 'Student Management',
          icon: Icons.school,
          screen: const StudentManagementScreen(),
        ),

        _tile(
          context,
          title: 'Teacher Management',
          icon: Icons.person,
          screen: const TeacherManagementScreen(),
        ),

        _tile(
          context,
          title: 'Student Directory',
          icon: Icons.badge,
          screen: const StudentDirectoryScreen(),
        ),

        _tile(
          context,
          title: 'Parent-Student Linking',
          icon: Icons.link,
          screen: const ParentStudentLinkScreen(),
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
      margin: const EdgeInsets.only(bottom: 12),
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
