import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final utrController = TextEditingController();

  bool isLoading = false;

  Future<void> submitPayment() async {
    if (utrController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter UTR Number")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final studentDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Duplicate pending request check
      final existingPayment = await FirebaseFirestore.instance
          .collection('payments')
          .where('studentId', isEqualTo: user.uid)
          .where('status', isEqualTo: 'pending')
          .get();

      if (existingPayment.docs.isNotEmpty) {
        throw Exception("You already have a pending payment request.");
      }

      // Create payment request
      await FirebaseFirestore.instance.collection('payments').add({
        "studentId": user.uid,
        "studentName": studentDoc.data()?['name'] ?? '',
        "email": studentDoc.data()?['email'] ?? '',

        "plan": "monthly",
        "amount": 149,
        "durationDays": 30,

        "utrNumber": utrController.text.trim(),

        "status": "pending",

        "createdAt": FieldValue.serverTimestamp(),
      });

      // Update user status
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {"paymentStatus": "pending"},
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Payment Submitted"),
          content: const Text(
            "Your payment request has been sent for verification.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
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
    utrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subscription Payment")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Founder Batch Offer",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "All Subjects Access",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "₹149 / Month",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Scan PhonePe QR and Pay",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            Image.asset('assets/qr/phonepe_qr.png', height: 250),

            const SizedBox(height: 30),

            TextField(
              controller: utrController,
              decoration: const InputDecoration(
                labelText: "Enter UTR Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitPayment,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Submit Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
