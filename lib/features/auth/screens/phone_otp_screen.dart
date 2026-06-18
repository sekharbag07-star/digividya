import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/otp_service.dart';
import '../services/account_service.dart';

import '../widgets/otp_header.dart';
import '../widgets/otp_input.dart';
import '../widgets/otp_actions.dart';

import 'login_screen.dart';

class PhoneOtpScreen extends StatefulWidget {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;

  const PhoneOtpScreen({
    super.key,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final TextEditingController otpController = TextEditingController();

  final OtpService _otpService = OtpService();

  final AccountService _accountService = AccountService();

  String verificationId = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    sendOtp();
  }

  Future<void> sendOtp() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    await _otpService.sendOtp(
      phoneNumber: '+91${widget.phoneNumber}',

      onCodeSent: (verId) {
        if (!mounted) return;

        verificationId = verId;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('OTP Sent Successfully')));
      },

      onFailed: (e) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'OTP Failed')));
      },

      onAutoVerify: (credential) async {
        await verifyAndCreateAccount(credential);
      },
    );
  }

  Future<void> verifyOtp() async {
    if (otpController.text.trim().length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter valid OTP')));
      return;
    }

    try {
      final credential = _otpService.createCredential(
        verificationId: verificationId,
        otp: otpController.text.trim(),
      );

      await verifyAndCreateAccount(credential);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> verifyAndCreateAccount(PhoneAuthCredential credential) async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      await _accountService.checkPhoneCredential(credential);

      final userCredential = await _accountService.createAccount(
        email: widget.email.trim(),
        password: widget.password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-created');
      }

      await _accountService.sendEmailVerification(user);

      await _accountService.createStudentRecord(
        uid: user.uid,
        fullName: widget.fullName,
        phoneNumber: widget.phoneNumber,
        email: widget.email.trim(),
      );

      await _accountService.logout();

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text(
            'Phone verified successfully.\n\nEmail verification link sent.\n\nPlease verify your email before login.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration Failed')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Verification')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            OtpHeader(phoneNumber: widget.phoneNumber),

            const SizedBox(height: 20),

            OtpInput(controller: otpController),

            const SizedBox(height: 20),

            OtpActions(
              isLoading: isLoading,
              onVerify: verifyOtp,
              onResend: sendOtp,
            ),
          ],
        ),
      ),
    );
  }
}
