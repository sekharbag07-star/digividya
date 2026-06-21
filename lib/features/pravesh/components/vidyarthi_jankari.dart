import 'package:flutter/material.dart';

class VidyarthiJankari extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController ageController;

  final String selectedClass;
  final Function(String) onClassChanged;

  final String selectedGender;
  final Function(String) onGenderChanged;

  const VidyarthiJankari({
    super.key,
    required this.fullNameController,
    required this.dobController,
    required this.ageController,
    required this.selectedClass,
    required this.onClassChanged,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  State<VidyarthiJankari> createState() => _VidyarthiJankariState();
}

class _VidyarthiJankariState extends State<VidyarthiJankari> {
  final List<String> classes = [
    "Class 1",
    "Class 2",
    "Class 3",
    "Class 4",
    "Class 5",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10",
  ];

  Future<void> selectDob() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2015),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    widget.dobController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

    final now = DateTime.now();

    int years = now.year - pickedDate.year;

    int months = now.month - pickedDate.month;

    if (months < 0) {
      years--;
      months += 12;
    }

    widget.ageController.text = "$years Years $months Months";
  }

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
                "Vidyarthi Jankari",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Photo Upload Next Step")),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Student Photo"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: widget.fullNameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: widget.dobController,
              readOnly: true,
              onTap: selectDob,
              decoration: const InputDecoration(
                labelText: "Date Of Birth",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_month),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: widget.ageController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Calculated Age",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cake),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: widget.selectedGender,
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                widget.onGenderChanged(value!);
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: widget.selectedClass,
              decoration: const InputDecoration(
                labelText: "Class",
                border: OutlineInputBorder(),
              ),
              items: classes.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                widget.onClassChanged(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}





