import 'package:flutter/material.dart';

import 'dashboard/screens/dashboard_tab.dart';
import 'users/screens/users_tab.dart';
import 'academics/screens/academics_tab.dart';
import 'finance/screens/finance_tab.dart';
import 'settings/screens/settings_tab.dart';

import '../study_material/screens/material_list_screen.dart';
import '../live_classes/screens/live_class_list_screen.dart';
import '../notices/screens/notice_list_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Panel"),
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Dashboard"),
              Tab(text: "Users"),
              Tab(text: "Academics"),
              Tab(text: "Finance"),
              Tab(text: "Materials"),
              Tab(text: "Live Classes"),
              Tab(text: "Notices"),
              Tab(text: "Settings"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DashboardTab(),
            UsersTab(),
            AcademicsTab(),
            FinanceTab(),
            MaterialListScreen(),
            LiveClassListScreen(),
            NoticeListScreen(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}
