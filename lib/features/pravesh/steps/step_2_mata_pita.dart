import 'package:flutter/material.dart';

import 'package:digividya/features/pravesh/components/mata_pita_jankari.dart';

class Step2MataPita extends StatelessWidget {
  final TextEditingController fatherNameController;
  final TextEditingController fatherMobileController;
  final TextEditingController fatherWhatsappController;
  final TextEditingController fatherEmailController;
  final TextEditingController fatherOccupationController;

  final TextEditingController motherNameController;
  final TextEditingController motherMobileController;
  final TextEditingController motherWhatsappController;
  final TextEditingController motherEmailController;
  final TextEditingController motherOccupationController;

  final TextEditingController familyIncomeController;

  final TextEditingController emergencyNameController;
  final TextEditingController emergencyMobileController;

  const Step2MataPita({
    super.key,
    required this.fatherNameController,
    required this.fatherMobileController,
    required this.fatherWhatsappController,
    required this.fatherEmailController,
    required this.fatherOccupationController,
    required this.motherNameController,
    required this.motherMobileController,
    required this.motherWhatsappController,
    required this.motherEmailController,
    required this.motherOccupationController,
    required this.familyIncomeController,
    required this.emergencyNameController,
    required this.emergencyMobileController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MataPitaJankari(
        fatherNameController: fatherNameController,
        fatherMobileController: fatherMobileController,
        fatherWhatsappController: fatherWhatsappController,
        fatherEmailController: fatherEmailController,
        fatherOccupationController: fatherOccupationController,
        motherNameController: motherNameController,
        motherMobileController: motherMobileController,
        motherWhatsappController: motherWhatsappController,
        motherEmailController: motherEmailController,
        motherOccupationController: motherOccupationController,
        familyIncomeController: familyIncomeController,
        emergencyNameController: emergencyNameController,
        emergencyMobileController: emergencyMobileController,
      ),
    );
  }
}







