import 'package:flutter/material.dart';

import 'package:digividya/features/live_classes/models/live_class_model.dart';
import 'package:digividya/core/services/live_class_service.dart';

class AddLiveClassScreen extends StatefulWidget {
  const AddLiveClassScreen({super.key});

  @override
  State<AddLiveClassScreen> createState() =>
      _AddLiveClassScreenState();
}

class _AddLiveClassScreenState
    extends State<AddLiveClassScreen> {
  final _titleController = TextEditingController();
  final _teacherController = TextEditingController();
  final _linkController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  final LiveClassService _service =
      LiveClassService();

  bool isLoading = false;

  Future<void> saveClass() async {
    if (_titleController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final liveClass = LiveClassModel(
      id: '',
      title: _titleController.text.trim(),
      teacher: _teacherController.text.trim(),
      meetingLink: _linkController.text.trim(),
      date: _dateController.text.trim(),
      time: _timeController.text.trim(),
      isActive: true,
    );

    await _service.addLiveClass(liveClass);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Live Class Created Successfully",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Live Class"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Class Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _teacherController,
              decoration: const InputDecoration(
                labelText: "Teacher Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: "Meeting Link",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: "Time",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed:
                    isLoading ? null : saveClass,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Create Live Class",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







