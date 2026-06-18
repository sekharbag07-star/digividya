import 'package:flutter/material.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;

  const OtpInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: const InputDecoration(
        labelText: 'Enter OTP',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }
}
