import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/leave_request_service.dart';

class ParentLeaveRequestScreen extends StatefulWidget {
  const ParentLeaveRequestScreen({super.key});

  @override
  State<ParentLeaveRequestScreen> createState() =>
      _ParentLeaveRequestScreenState();
}

class _ParentLeaveRequestScreenState extends State<ParentLeaveRequestScreen> {
  final reasonController = TextEditingController();

  bool isLoading = false;

  Future<void> submitRequest() async {
    if (reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter leave reason')));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final parentDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = parentDoc.data() ?? {};

      await LeaveRequestService().submitLeaveRequest(
        parentUid: user.uid,
        parentName: data['name'] ?? 'Parent',
        studentUid: data['studentUid'] ?? '',
        reason: reasonController.text.trim(),
      );

      reasonController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Leave request submitted')));
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
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Request')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: reasonController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Leave Reason',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitRequest,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit Leave Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
