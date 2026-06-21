import 'package:flutter/material.dart';

import 'package:digividya/features/study_material/models/study_material_model.dart';
import 'package:digividya/core/services/study_material_service.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _titleController = TextEditingController();

  final _subjectController = TextEditingController();

  final _batchController = TextEditingController();

  final _urlController = TextEditingController();

  final StudyMaterialService _service = StudyMaterialService();

  String selectedType = 'pdf';

  Future<void> saveMaterial() async {
    final material = StudyMaterialModel(
      id: '',
      title: _titleController.text.trim(),
      subject: _subjectController.text.trim(),
      batch: _batchController.text.trim(),
      type: selectedType,
      fileUrl: _urlController.text.trim(),
      createdAt: DateTime.now(),
    );

    await _service.addMaterial(material);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Study Material')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _batchController,
              decoration: const InputDecoration(labelText: 'Batch'),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField(
              initialValue: selectedType,
              items: const [
                DropdownMenuItem(value: 'pdf', child: Text('PDF')),
                DropdownMenuItem(value: 'video', child: Text('Video')),
                DropdownMenuItem(value: 'youtube', child: Text('YouTube')),
                DropdownMenuItem(value: 'notes', child: Text('Notes')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value.toString();
                });
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'File / Video URL'),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: saveMaterial,
              child: const Text('Save Material'),
            ),
          ],
        ),
      ),
    );
  }
}







