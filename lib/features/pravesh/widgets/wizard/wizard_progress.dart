import 'package:flutter/material.dart';

class WizardProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const WizardProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: (currentStep + 1) / totalSteps),
        const SizedBox(height: 10),
        Text(
          "Step ${currentStep + 1} of $totalSteps",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
