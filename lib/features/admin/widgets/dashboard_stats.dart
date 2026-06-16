import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  final int studentsCount;
  final int teachersCount;
  final int batchesCount;
  final int feesCount;
  final double totalCollection;
  final double pendingAmount;

  const DashboardStats({
    super.key,
    required this.studentsCount,
    required this.teachersCount,
    required this.batchesCount,
    required this.feesCount,
    required this.totalCollection,
    required this.pendingAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        statCard("Students", studentsCount.toString(), Icons.school),
        const SizedBox(height: 10),

        statCard("Teachers", teachersCount.toString(), Icons.person),
        const SizedBox(height: 10),

        statCard("Batches", batchesCount.toString(), Icons.groups),
        const SizedBox(height: 10),

        statCard("Fees", feesCount.toString(), Icons.receipt_long),
        const SizedBox(height: 10),

        statCard(
          "Collection",
          "₹${totalCollection.toStringAsFixed(0)}",
          Icons.account_balance_wallet,
        ),
        const SizedBox(height: 10),

        statCard(
          "Pending",
          "₹${pendingAmount.toStringAsFixed(0)}",
          Icons.warning_amber_rounded,
        ),
      ],
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B1033), Color(0xFF132B5E)],
        ),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(0xFFFFD700),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFFFD700),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}