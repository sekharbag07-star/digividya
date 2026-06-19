import 'package:flutter/material.dart';

class PraveshController {
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
  }
}
