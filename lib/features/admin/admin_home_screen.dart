import 'package:flutter/material.dart';

import 'dashboard/screens/dashboard_tab.dart';
import 'users/screens/users_tab.dart';
import 'academics/screens/academics_tab.dart';
import 'finance/screens/finance_tab.dart';
import 'settings/screens/settings_tab.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}
