import 'package:flutter/material.dart';

class SchoolJankari extends StatelessWidget {
  final TextEditingController previousSchoolController;
  final TextEditingController currentSchoolController;
  final TextEditingController schoolAddressController;
  final TextEditingController previousPercentageController;

  final String selectedBoard;
  final String selectedClass;

  final ValueChanged<String?> onBoardChanged;
  final ValueChanged<String?> onClassChanged;

  const SchoolJankari({
    super.key,
    required this.previousSchoolController,
    required this.currentSchoolController,
    required this.schoolAddressController,
    required this.previousPercentageController,
    required this.selectedBoard,
    required this.selectedClass,
    required this.onBoardChanged,
    required this.onClassChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "School Jankari",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: previousSchoolController,
              decoration: const InputDecoration(
                labelText: "Previous School Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: currentSchoolController,
              decoration: const InputDecoration(
                labelText: "Current School Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school_outlined),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: schoolAddressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "School Address",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedBoard,
              decoration: const InputDecoration(
                labelText: "Board",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "CBSE", child: Text("CBSE")),
                DropdownMenuItem(value: "ICSE", child: Text("ICSE")),
                DropdownMenuItem(value: "STATE", child: Text("STATE BOARD")),
              ],
              onChanged: onBoardChanged,
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedClass,
              decoration: const InputDecoration(
                labelText: "Current Class",
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                10,
                (index) => DropdownMenuItem(
                  value: "Class ${index + 1}",
                  child: Text("Class ${index + 1}"),
                ),
              ),
              onChanged: onClassChanged,
            ),

            const SizedBox(height: 12),

            TextField(
              controller: previousPercentageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Previous Exam Percentage",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.bar_chart),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Agar student pehle se kisi school me padh raha hai to Admit Card / ID Card upload karna mandatory hoga.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



