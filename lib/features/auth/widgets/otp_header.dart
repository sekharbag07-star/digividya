import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const OtpHeader({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.phone_android, size: 80, color: Colors.blue),

        const SizedBox(height: 20),

        Text(
          '+91$phoneNumber',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}





