import 'package:flutter/material.dart';

class WizardNavigation extends StatelessWidget {
  final int currentStep;
  final int lastStep;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const WizardNavigation({
    super.key,
    required this.currentStep,
    required this.lastStep,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: currentStep == 0 ? null : onBack,
            child: const Text("Back"),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ElevatedButton(
            onPressed: onNext,
            child: Text(currentStep == lastStep ? "Submit" : "Next"),
          ),
        ),
      ],
    );
  }
}
