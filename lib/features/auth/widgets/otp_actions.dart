import 'package:flutter/material.dart';

class OtpActions extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onVerify;
  final VoidCallback onResend;

  const OtpActions({
    super.key,
    required this.isLoading,
    required this.onVerify,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isLoading ? null : onVerify,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Verify OTP'),
          ),
        ),

        const SizedBox(height: 10),

        TextButton(
          onPressed: isLoading ? null : onResend,
          child: const Text('Resend OTP'),
        ),
      ],
    );
  }
}



