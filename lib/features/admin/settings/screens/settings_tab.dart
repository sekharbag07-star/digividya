import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:digividya/features/auth/screens/login_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: ListTile(
            leading: Icon(Icons.business),
            title: Text('Institute Settings'),
            subtitle: Text('Coming Soon'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification Settings'),
            subtitle: Text('Coming Soon'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Admin Profile'),
            subtitle: Text('Coming Soon'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => logout(context),
          ),
        ),
      ],
    );
  }
}





