import 'dart:math';

import 'package:flutter/material.dart';

import '../../../users/student/screens/student_management_screen.dart';
import '../../../users/teacher/screens/teacher_management_screen.dart';

import '../../../academics/batches/screens/batch_management_screen.dart';

import '../../../finance/fees/screens/fee_management_screen.dart';
import '../../../finance/payments/screens/payment_approval_screen.dart';

import 'lotus_center.dart';
import 'lotus_petal.dart';
import 'lotus_ring.dart';

class LotusDashboard extends StatelessWidget {
  final int studentsCount;
  final int teachersCount;
  final int batchesCount;
  final int feesCount;
  final double totalCollection;
  final double pendingAmount;

  const LotusDashboard({
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
    final petals = [
      _PetalItem(
        title: "Students",
        value: studentsCount.toString(),
        icon: Icons.school,
        screen: const StudentManagementScreen(),
      ),

      _PetalItem(
        title: "Teachers",
        value: teachersCount.toString(),
        icon: Icons.person,
        screen: const TeacherManagementScreen(),
      ),

      _PetalItem(
        title: "Batches",
        value: batchesCount.toString(),
        icon: Icons.groups,
        screen: const BatchManagementScreen(),
      ),

      _PetalItem(
        title: "Revenue",
        value: "₹${totalCollection.toStringAsFixed(0)}",
        icon: Icons.account_balance_wallet,
        screen: const FeeManagementScreen(),
      ),

      _PetalItem(
        title: "Fees",
        value: feesCount.toString(),
        icon: Icons.receipt_long,
        screen: const FeeManagementScreen(),
      ),

      _PetalItem(
        title: "Pending",
        value: "₹${pendingAmount.toStringAsFixed(0)}",
        icon: Icons.warning_amber_rounded,
        screen: const PaymentApprovalScreen(),
      ),
    ];

    return SizedBox(
      height: 500,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const LotusRing(),

          for (int i = 0; i < petals.length; i++)
            Transform.translate(
              offset: Offset(
                cos((pi / 3) * i - pi / 2) * 170,
                sin((pi / 3) * i - pi / 2) * 170,
              ),
              child: LotusPetal(
                title: petals[i].title,
                value: petals[i].value,
                icon: petals[i].icon,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => petals[i].screen),
                  );
                },
              ),
            ),

          const LotusCenter(),
        ],
      ),
    );
  }
}

class _PetalItem {
  final String title;
  final String value;
  final IconData icon;
  final Widget screen;

  _PetalItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.screen,
  });
}



