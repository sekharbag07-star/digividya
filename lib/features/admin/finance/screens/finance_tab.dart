import 'package:flutter/material.dart';

import '../fees/screens/fee_management_screen.dart';
import '../payments/screens/payment_approval_screen.dart';

class FinanceTab extends StatelessWidget {
  const FinanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _tile(
          context,
          title: 'Fee Management',
          icon: Icons.currency_rupee,
          screen: const FeeManagementScreen(),
        ),
        _tile(
          context,
          title: 'Payment Approval',
          icon: Icons.verified,
          screen: const PaymentApprovalScreen(),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Revenue Analytics'),
            subtitle: const Text('Coming Soon'),
            trailing: const Icon(Icons.lock_outline),
          ),
        ),
      ],
    );
  }

  Widget _tile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}



