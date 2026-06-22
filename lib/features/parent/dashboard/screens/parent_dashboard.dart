import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/auth/screens/login_screen.dart';

import 'package:digividya/features/parent/attendance/screens/parent_attendance_screen.dart';
import 'package:digividya/features/parent/fees/screens/parent_fee_screen.dart';
import 'package:digividya/features/parent/results/screens/parent_result_screen.dart';
import 'package:digividya/features/parent/notices/screens/parent_notice_screen.dart';
import 'package:digividya/features/parent/profile/screens/parent_profile_screen.dart';

import 'package:digividya/features/parent/complaints/screens/parent_complaint_screen.dart';
import 'package:digividya/features/parent/suggestions/screens/parent_suggestion_screen.dart';
import 'package:digividya/features/parent/leave_request/screens/parent_leave_request_screen.dart';
import 'package:digividya/features/parent/meeting_request/screens/parent_meeting_request_screen.dart';
import 'package:digividya/features/parent/chat/screens/parent_chat_screen.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void openScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  Widget dashboardCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return InkWell(
      onTap: () => openScreen(context, screen),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.blue.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: Colors.blue.shade700),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            dashboardCard(
              context: context,
              title: "Attendance",
              icon: Icons.calendar_month,
              screen: const ParentAttendanceScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Fees",
              icon: Icons.currency_rupee,
              screen: const ParentFeeScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Results",
              icon: Icons.bar_chart,
              screen: const ParentResultScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Notices",
              icon: Icons.campaign,
              screen: const ParentNoticeScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Profile",
              icon: Icons.person,
              screen: const ParentProfileScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Complaint",
              icon: Icons.report_problem,
              screen: const ParentComplaintScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Suggestion",
              icon: Icons.lightbulb,
              screen: const ParentSuggestionScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Leave Request",
              icon: Icons.event_busy,
              screen: const ParentLeaveRequestScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Meeting Request",
              icon: Icons.groups,
              screen: const ParentMeetingRequestScreen(),
            ),
            dashboardCard(
              context: context,
              title: "Chat Institute",
              icon: Icons.chat,
              screen: const ParentChatScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
