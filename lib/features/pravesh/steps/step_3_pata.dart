import 'package:flutter/material.dart';

import 'package:digividya/features/pravesh/components/pata_jankari.dart';

class Step3Pata extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pinCodeController;

  final TextEditingController areaController;
  final TextEditingController landmarkController;

  const Step3Pata({
    super.key,
    required this.addressController,
    required this.cityController,
    required this.stateController,
    required this.pinCodeController,
    required this.areaController,
    required this.landmarkController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PataJankari(
        addressController: addressController,
        cityController: cityController,
        stateController: stateController,
        pinCodeController: pinCodeController,
        areaController: areaController,
        landmarkController: landmarkController,
      ),
    );
  }
}







