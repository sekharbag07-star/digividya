import 'package:flutter/material.dart';

class ParentFeeScreen extends StatelessWidget {
  const ParentFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fee Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.currency_rupee),
                title: const Text('Total Fees'),
                subtitle: const Text('₹15,000'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Paid'),
                subtitle: const Text('₹10,000'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.warning, color: Colors.orange),
                title: const Text('Pending'),
                subtitle: const Text('₹5,000'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
