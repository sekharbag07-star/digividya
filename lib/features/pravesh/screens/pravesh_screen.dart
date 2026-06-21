import 'package:flutter/material.dart';

import 'package:digividya/features/payment/screens/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digividya/features/pravesh/services/pravesh_service.dart';
import 'package:digividya/features/pravesh/widgets/wizard/wizard_progress.dart';
import 'package:digividya/features/pravesh/widgets/wizard/wizard_navigation.dart';

import 'package:digividya/features/pravesh/steps/step_1_vidyarthi.dart';
import 'package:digividya/features/pravesh/steps/step_2_mata_pita.dart';
import 'package:digividya/features/pravesh/steps/step_3_pata.dart';
import 'package:digividya/features/pravesh/steps/step_4_school.dart';
import 'package:digividya/features/pravesh/steps/step_5_yojana.dart';
import 'package:digividya/features/pravesh/steps/step_6_dastavej.dart';
import 'package:digividya/features/pravesh/steps/step_7_terms.dart';

class PraveshScreen extends StatefulWidget {
  const PraveshScreen({super.key});

  @override
  State<PraveshScreen> createState() => _PraveshScreenState();
}

class _PraveshScreenState extends State<PraveshScreen> {
  int currentStep = 0;
  final PraveshService _praveshService = PraveshService();

  bool isSubmitting = false;

  // STEP 1
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();

  String selectedClass = "Class 1";
  String selectedGender = "Male";

  // STEP 2
  final fatherNameController = TextEditingController();
  final fatherMobileController = TextEditingController();
  final fatherWhatsappController = TextEditingController();
  final fatherEmailController = TextEditingController();
  final fatherOccupationController = TextEditingController();

  final motherNameController = TextEditingController();
  final motherMobileController = TextEditingController();
  final motherWhatsappController = TextEditingController();
  final motherEmailController = TextEditingController();
  final motherOccupationController = TextEditingController();

  final familyIncomeController = TextEditingController();

  final emergencyNameController = TextEditingController();
  final emergencyMobileController = TextEditingController();

  // STEP 3
  final addressController = TextEditingController();
  final areaController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  // STEP 4
  final previousSchoolController = TextEditingController();
  final currentSchoolController = TextEditingController();
  final schoolAddressController = TextEditingController();
  final previousPercentageController = TextEditingController();

  String selectedBoard = "CBSE";

  // STEP 5
  String selectedPlan = '';

  // STEP 7
  final parentConsentController = TextEditingController();
  bool termsAccepted = false;

  final List<String> titles = [
    'Vidyarthi',
    'Mata Pita',
    'Pata',
    'School',
    'Yojana',
    'Dastavej',
    'Terms',
  ];

  Widget getCurrentStep() {
    switch (currentStep) {
      case 0:
        return Step1Vidyarthi(
          fullNameController: fullNameController,
          dobController: dobController,
          ageController: ageController,
          selectedClass: selectedClass,
          selectedGender: selectedGender,
          onClassChanged: (value) {
            setState(() {
              selectedClass = value;
            });
          },
          onGenderChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        );

      case 1:
        return Step2MataPita(
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
        );

      case 2:
        return Step3Pata(
          addressController: addressController,
          cityController: cityController,
          stateController: stateController,
          pinCodeController: pinCodeController,
          areaController: areaController,
          landmarkController: landmarkController,
        );

      case 3:
        return Step4School(
          previousSchoolController: previousSchoolController,
          currentSchoolController: currentSchoolController,
          schoolAddressController: schoolAddressController,
          previousPercentageController: previousPercentageController,
          selectedBoard: selectedBoard,
          selectedClass: selectedClass,
          onBoardChanged: (value) {
            if (value == null) return;
            setState(() {
              selectedBoard = value;
            });
          },
          onClassChanged: (_) {},
        );

      case 4:
        return Step5Yojana(
          selectedClass: selectedClass,
          selectedPlan: selectedPlan,
          onPlanChanged: (value) {
            setState(() {
              selectedPlan = value ?? '';
            });
          },
        );

      case 5:
        return Step6Dastavej(
          onStudentPhoto: () {},
          onBirthCertificate: () {},
          onAadhaarCard: () {},
          onSchoolId: () {},
          onParentAadhaar: () {},
          onAddressProof: () {},
        );

      case 6:
        return Step7Terms(
          termsAccepted: termsAccepted,
          parentConsentController: parentConsentController,
          onTermsChanged: (value) {
            setState(() {
              termsAccepted = value ?? false;
            });
          },
        );

      default:
        return const SizedBox();
    }
  }

  Future<void> submitForm() async {
    if (!termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept terms & conditions")),
      );
      return;
    }

    try {
      setState(() {
        isSubmitting = true;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      await _praveshService.savePravesh(
        uid: user.uid,

        fullName: fullNameController.text.trim(),
        dob: dobController.text.trim(),
        age: ageController.text.trim(),
        gender: selectedGender,
        studentClass: selectedClass,

        fatherName: fatherNameController.text.trim(),
        fatherMobile: fatherMobileController.text.trim(),
        fatherWhatsapp: fatherWhatsappController.text.trim(),
        fatherEmail: fatherEmailController.text.trim(),

        motherName: motherNameController.text.trim(),
        motherMobile: motherMobileController.text.trim(),
        motherWhatsapp: motherWhatsappController.text.trim(),
        motherEmail: motherEmailController.text.trim(),

        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        pincode: pinCodeController.text.trim(),

        alreadyStudying: currentSchoolController.text.trim().isNotEmpty,

        currentSchool: currentSchoolController.text.trim(),
        previousSchool: previousSchoolController.text.trim(),

        selectedPlan: selectedPlan,
        planAmount: 0,

        parentConsentName: parentConsentController.text.trim(),

        termsAccepted: termsAccepted,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PaymentScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    ageController.dispose();

    fatherNameController.dispose();
    fatherMobileController.dispose();
    fatherWhatsappController.dispose();
    fatherEmailController.dispose();
    fatherOccupationController.dispose();

    motherNameController.dispose();
    motherMobileController.dispose();
    motherWhatsappController.dispose();
    motherEmailController.dispose();
    motherOccupationController.dispose();

    familyIncomeController.dispose();

    emergencyNameController.dispose();
    emergencyMobileController.dispose();

    addressController.dispose();
    areaController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();

    previousSchoolController.dispose();
    currentSchoolController.dispose();
    schoolAddressController.dispose();
    previousPercentageController.dispose();

    parentConsentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admission Form")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WizardProgress(currentStep: currentStep, totalSteps: 7),

            const SizedBox(height: 20),

            Expanded(child: getCurrentStep()),

            WizardNavigation(
              currentStep: currentStep,
              lastStep: 6,
              onBack: () {
                setState(() {
                  currentStep--;
                });
              },
              onNext: () {
                if (currentStep < 6) {
                  setState(() {
                    currentStep++;
                  });
                } else {
                  submitForm();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}








