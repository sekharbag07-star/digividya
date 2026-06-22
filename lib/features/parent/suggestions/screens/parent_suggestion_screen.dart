import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/suggestion_service.dart';

class ParentSuggestionScreen extends StatefulWidget {
  const ParentSuggestionScreen({super.key});

  @override
  State<ParentSuggestionScreen> createState() => _ParentSuggestionScreenState();
}

class _ParentSuggestionScreenState extends State<ParentSuggestionScreen> {
  final controller = TextEditingController();

  bool isLoading = false;

  Future<void> submitSuggestion() async {
    if (controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter suggestion')));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final parentName = doc.data()?['name']?.toString() ?? 'Parent';

      await SuggestionService().submitSuggestion(
        parentUid: user.uid,
        parentName: parentName,
        suggestion: controller.text.trim(),
      );

      controller.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Suggestion submitted successfully')),
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggestion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Write Suggestion',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitSuggestion,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit Suggestion'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
