import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final otpController = TextEditingController();

  String verificationId = '';
  bool isLoading = false;
  bool otpSent = false;

  @override
  void initState() {
    super.initState();
    sendOtp();
  }

  Future<void> sendOtp() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await verifyAndCreateAccount(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'OTP Failed')),
        );
      },
      codeSent: (String verId, int? resendToken) {
        verificationId = verId;

        setState(() {
          otpSent = true;
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP Sent Successfully'),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyOtp() async {
    if (otpController.text.trim().length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter valid OTP'),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await verifyAndCreateAccount(credential);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> verifyAndCreateAccount(
    PhoneAuthCredential credential,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      await userCredential.user!.sendEmailVerification();

      final uid = userCredential.user!.uid;

      final now = DateTime.now();
      final trialEnd = now.add(
        const Duration(days: 7),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
        'name': widget.fullName,
        'phone': widget.phoneNumber,
        'phoneVerified': true,
        'email': widget.email,
        'role': 'student',
        'active': true,

        'trialActive': true,
        'trialStartDate': Timestamp.fromDate(now),
        'trialEndDate': Timestamp.fromDate(trialEnd),

        'subscriptionActive': false,
        'subscriptionStartDate': null,
        'subscriptionEndDate': null,

        'paymentStatus': 'trial',
        'selectedPlan': 'Founder ₹149',
        'transactionId': '',

        'createdAt': Timestamp.now(),
      });

      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text(
            'Phone verified.\n\nEmail verification link sent.\n\nVerify email and login.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
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
      appBar: AppBar(
        title: const Text('Phone Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.phone_android,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              '+91${widget.phoneNumber}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    isLoading ? null : verifyOtp,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Verify OTP',
                      ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: sendOtp,
              child: const Text(
                'Resend OTP',
              ),
            ),
          ],
        ),
      ),
    );
  }
}