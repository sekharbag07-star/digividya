import 'package:flutter/material.dart';

class DastavejUpload extends StatelessWidget {
  final VoidCallback onStudentPhoto;
  final VoidCallback onBirthCertificate;
  final VoidCallback onAadhaarCard;
  final VoidCallback onSchoolId;
  final VoidCallback onParentAadhaar;
  final VoidCallback onAddressProof;

  const DastavejUpload({
    super.key,
    required this.onStudentPhoto,
    required this.onBirthCertificate,
    required this.onAadhaarCard,
    required this.onSchoolId,
    required this.onParentAadhaar,
    required this.onAddressProof,
  });

  Widget uploadTile({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool mandatory = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          mandatory ? "$description\nMandatory Document" : description,
        ),
        trailing: const Icon(Icons.upload_file, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dastavej Upload",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            uploadTile(
              title: "Student Photo",
              description: "Camera ya Gallery se latest photo upload karein",
              icon: Icons.person,
              mandatory: true,
              onTap: onStudentPhoto,
            ),

            uploadTile(
              title: "Birth Certificate",
              description: "Janm Praman Patra upload karein",
              icon: Icons.cake,
              mandatory: true,
              onTap: onBirthCertificate,
            ),

            uploadTile(
              title: "Student Aadhaar Card",
              description: "Student Aadhaar Front/Back",
              icon: Icons.badge,
              mandatory: true,
              onTap: onAadhaarCard,
            ),

            uploadTile(
              title: "School ID / Admit Card",
              description:
                  "Agar student pehle se school me padh raha hai to mandatory",
              icon: Icons.school,
              mandatory: true,
              onTap: onSchoolId,
            ),

            uploadTile(
              title: "Parent Aadhaar",
              description: "Mata ya Pita ka Aadhaar",
              icon: Icons.family_restroom,
              mandatory: true,
              onTap: onParentAadhaar,
            ),

            uploadTile(
              title: "Address Proof",
              description: "Electricity Bill / Ration Card / Aadhaar",
              icon: Icons.home,
              mandatory: true,
              onTap: onAddressProof,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "Document Guidelines",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Text("• Sabhi documents clear hone chahiye."),

                  Text("• JPG, PNG aur PDF supported honge."),

                  Text("• Student Photo latest hona chahiye."),

                  Text(
                    "• School Admit Card mandatory hai agar student pehle se school me enrolled hai.",
                  ),

                  Text(
                    "• Sabhi mandatory documents ke bina registration approve nahi hoga.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Sabhi mandatory documents upload kiye bina admission complete nahi hoga.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





