import 'package:flutter/material.dart';

import '../components/school_jankari.dart';

class Step4School extends StatelessWidget {
  final TextEditingController previousSchoolController;
  final TextEditingController currentSchoolController;
  final TextEditingController schoolAddressController;
  final TextEditingController previousPercentageController;

  final String selectedBoard;
  final String selectedClass;

  final ValueChanged<String?> onBoardChanged;
  final ValueChanged<String?> onClassChanged;

  const Step4School({
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
    return SingleChildScrollView(
      child: SchoolJankari(
        previousSchoolController: previousSchoolController,
        currentSchoolController: currentSchoolController,
        schoolAddressController: schoolAddressController,
        previousPercentageController: previousPercentageController,
        selectedBoard: selectedBoard,
        selectedClass: selectedClass,
        onBoardChanged: onBoardChanged,
        onClassChanged: onClassChanged,
      ),
    );
  }
}



