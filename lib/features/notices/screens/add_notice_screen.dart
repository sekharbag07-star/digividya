import 'package:flutter/material.dart';

import 'package:digividya/features/notices/models/notice_model.dart';
import 'package:digividya/core/services/notice_service.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({super.key});

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final NoticeService _noticeService = NoticeService();

  String selectedType = 'text';
  String selectedRole = 'all';

  bool isLoading = false;

  Future<void> saveNotice() async {
    if (_titleController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final notice = NoticeModel(
      id: '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      type: selectedType,
      targetRole: selectedRole,
      fileUrl: '',
      createdAt: DateTime.now(),
    );

    await _noticeService.addNotice(notice);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Notice Added Successfully")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Notice")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedType,
              decoration: const InputDecoration(
                labelText: "Notice Type",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "text", child: Text("Text Notice")),
                DropdownMenuItem(
                  value: "payment",
                  child: Text("Payment Notice"),
                ),
                DropdownMenuItem(
                  value: "holiday",
                  child: Text("Holiday Notice"),
                ),
                DropdownMenuItem(
                  value: "important",
                  child: Text("Important Notice"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedRole,
              decoration: const InputDecoration(
                labelText: "Target Role",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "all", child: Text("All Users")),
                DropdownMenuItem(value: "student", child: Text("Students")),
                DropdownMenuItem(value: "teacher", child: Text("Teachers")),
                DropdownMenuItem(value: "parent", child: Text("Parents")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveNotice,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Publish Notice"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







