import 'package:flutter/material.dart';

class MataPitaJankari extends StatelessWidget {
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

  const MataPitaJankari({
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
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mata Pita Jankari",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // FATHER SECTION
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Father Details",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: fatherNameController,
              decoration: const InputDecoration(
                labelText: "Father Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: fatherMobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Father Mobile",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: fatherWhatsappController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Father WhatsApp Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.chat),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: fatherEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Father Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: fatherOccupationController,
              decoration: const InputDecoration(
                labelText: "Father Occupation",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
              ),
            ),

            const SizedBox(height: 25),

            // MOTHER SECTION
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mother Details",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: motherNameController,
              decoration: const InputDecoration(
                labelText: "Mother Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: motherMobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Mother Mobile",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: motherWhatsappController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Mother WhatsApp Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.chat_bubble),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: motherEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Mother Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: motherOccupationController,
              decoration: const InputDecoration(
                labelText: "Mother Occupation",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work_outline),
              ),
            ),

            const SizedBox(height: 25),

            // FAMILY INCOME
            TextField(
              controller: familyIncomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Annual Family Income",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
              ),
            ),

            const SizedBox(height: 25),

            // EMERGENCY CONTACT
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Emergency Contact",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emergencyNameController,
              decoration: const InputDecoration(
                labelText: "Emergency Contact Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.contact_emergency),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emergencyMobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Emergency Mobile Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.call),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Parent contact details admission, fees, attendance, result aur emergency communication ke liye use ki jayengi.",
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





