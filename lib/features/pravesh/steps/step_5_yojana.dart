import 'package:flutter/material.dart';

import '../components/yojana_chayan.dart';

class Step5Yojana extends StatelessWidget {
  final String selectedClass;
  final String selectedPlan;

  final ValueChanged<String?> onPlanChanged;

  const Step5Yojana({
    super.key,
    required this.selectedClass,
    required this.selectedPlan,
    required this.onPlanChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: YojanaChayan(
        selectedClass: selectedClass,
        selectedPlan: selectedPlan,
        onPlanChanged: onPlanChanged,
      ),
    );
  }
}





