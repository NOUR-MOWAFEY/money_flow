import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: .min,
      children: [
        const Text(
          'Available Balance',
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),

        ValueListenableBuilder<double>(
          valueListenable: BalanceController.balance,
          builder: (context, value, _) {
            return Text(
              'EGP $value',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}

class BalanceController {
  static final ValueNotifier<double> balance = ValueNotifier(0);

  static void updateBalance() {
    final transactions = HiveService().getTransactions();
    balance.value = transactions.fold(0.0, (sum, e) => sum + e.amount);
    log(balance.value.toString());
  }
}
