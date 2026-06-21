import 'package:flutter/material.dart';

import '../components/vidyarthi_jankari.dart';

class Step1Vidyarthi extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController ageController;

  final String selectedClass;
  final String selectedGender;

  final ValueChanged<String> onClassChanged;
  final ValueChanged<String> onGenderChanged;

  const Step1Vidyarthi({
    super.key,
    required this.fullNameController,
    required this.dobController,
    required this.ageController,
    required this.selectedClass,
    required this.selectedGender,
    required this.onClassChanged,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: VidyarthiJankari(
        fullNameController: fullNameController,
        dobController: dobController,
        ageController: ageController,
        selectedClass: selectedClass,
        selectedGender: selectedGender,
        onClassChanged: onClassChanged,
        onGenderChanged: onGenderChanged,
      ),
    );
  }
}





