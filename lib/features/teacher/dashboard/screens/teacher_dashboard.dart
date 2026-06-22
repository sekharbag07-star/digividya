import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/auth/screens/login_screen.dart';
import 'package:digividya/features/teacher/attendance/screens/teacher_attendance_screen.dart';
import 'package:digividya/features/teacher/assignments/screens/teacher_assignment_screen.dart';
import 'package:digividya/features/teacher/live_classes/screens/teacher_live_class_screen.dart';
import 'package:digividya/features/teacher/notices/screens/teacher_notice_screen.dart';
import 'package:digividya/features/teacher/study_material/screens/teacher_study_material_screen.dart';
import 'package:digividya/features/teacher/chat/screens/teacher_chat_list_screen.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _card(
            context,
            "Attendance",
            Icons.fact_check,
            const TeacherAttendanceScreen(),
          ),
          _card(
            context,
            "Assignments",
            Icons.assignment,
            const TeacherAssignmentScreen(),
          ),
          _card(
            context,
            "Live Classes",
            Icons.video_call,
            const TeacherLiveClassScreen(),
          ),
          _card(
            context,
            "Notices",
            Icons.campaign,
            const TeacherNoticeScreen(),
          ),
          _card(
            context,
            "Study Material",
            Icons.menu_book,
            const TeacherStudyMaterialScreen(),
          ),
          _card(
            context,
            "Parent Chat",
            Icons.chat,
            const TeacherChatListScreen(),
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
