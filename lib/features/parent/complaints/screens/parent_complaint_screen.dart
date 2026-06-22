import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/complaint_service.dart';

class ParentComplaintScreen extends StatefulWidget {
  const ParentComplaintScreen({super.key});

  @override
  State<ParentComplaintScreen> createState() => _ParentComplaintScreenState();
}

class _ParentComplaintScreenState extends State<ParentComplaintScreen> {
  final TextEditingController complaintController = TextEditingController();

  final ComplaintService _complaintService = ComplaintService();

  bool isLoading = false;

  Future<void> submitComplaint() async {
    if (complaintController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please write complaint')));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final parentName = userDoc.data()?['name'] ?? 'Parent';

      await _complaintService.submitComplaint(
        parentUid: user.uid,
        parentName: parentName,
        complaint: complaintController.text.trim(),
      );

      complaintController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully')),
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
    complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: complaintController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Write Complaint',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitComplaint,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit Complaint'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
