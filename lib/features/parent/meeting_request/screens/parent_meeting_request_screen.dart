import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/meeting_request_service.dart';

class ParentMeetingRequestScreen extends StatefulWidget {
  const ParentMeetingRequestScreen({super.key});

  @override
  State<ParentMeetingRequestScreen> createState() =>
      _ParentMeetingRequestScreenState();
}

class _ParentMeetingRequestScreenState
    extends State<ParentMeetingRequestScreen> {
  final purposeController = TextEditingController();

  bool isLoading = false;

  Future<void> submitRequest() async {
    if (purposeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter meeting purpose')));
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

      await MeetingRequestService().submitMeetingRequest(
        parentUid: user.uid,
        parentName: data['name'] ?? 'Parent',
        studentUid: data['studentUid'] ?? '',
        purpose: purposeController.text.trim(),
      );

      purposeController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meeting request submitted')),
      );
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
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meeting Request')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: purposeController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Meeting Purpose',
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
                    : const Text('Request Meeting'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
