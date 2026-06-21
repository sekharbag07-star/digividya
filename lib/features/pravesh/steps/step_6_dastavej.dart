import 'package:flutter/material.dart';

import 'package:digividya/features/pravesh/components/dastavej_upload.dart';

class Step6Dastavej extends StatelessWidget {
  final VoidCallback? onStudentPhoto;
  final VoidCallback? onBirthCertificate;
  final VoidCallback? onAadhaarCard;
  final VoidCallback? onSchoolId;
  final VoidCallback? onParentAadhaar;
  final VoidCallback? onAddressProof;

  const Step6Dastavej({
    super.key,
    this.onStudentPhoto,
    this.onBirthCertificate,
    this.onAadhaarCard,
    this.onSchoolId,
    this.onParentAadhaar,
    this.onAddressProof,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DastavejUpload(
        onStudentPhoto: onStudentPhoto ?? () {},
        onBirthCertificate: onBirthCertificate ?? () {},
        onAadhaarCard: onAadhaarCard ?? () {},
        onSchoolId: onSchoolId ?? () {},
        onParentAadhaar: onParentAadhaar ?? () {},
        onAddressProof: onAddressProof ?? () {},
      ),
    );
  }
}







