import 'package:flutter/material.dart';

class PataJankari extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController areaController;
  final TextEditingController landmarkController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pinCodeController;

  const PataJankari({
    super.key,
    required this.addressController,
    required this.areaController,
    required this.landmarkController,
    required this.cityController,
    required this.stateController,
    required this.pinCodeController,
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
                "Pata Jankari",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Poora Address",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: areaController,
              decoration: const InputDecoration(
                labelText: "Area / Mohalla",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: landmarkController,
              decoration: const InputDecoration(
                labelText: "Landmark",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: "City",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: stateController,
                    decoration: const InputDecoration(
                      labelText: "State",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextField(
              controller: pinCodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: "PIN Code",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pin_drop),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







