import 'package:flutter/material.dart';

class AiRoleBadge extends StatelessWidget {
  final String role;

  const AiRoleBadge({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    String label;

    switch (role) {
      case 'parent':
        label = 'Parent AI';
        break;

      case 'teacher':
        label = 'Teacher AI';
        break;

      case 'admin':
        label = 'Admin AI';
        break;

      default:
        label = 'Student AI';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
