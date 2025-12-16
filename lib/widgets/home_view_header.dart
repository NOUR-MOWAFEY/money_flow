import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/utils/show_confirmation_dialog.dart';
import 'package:money_flow/widgets/custom_app_bar.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        CustomAppBar(
          onTap: () {
            ShowConfirmationDialog.showConfirmationDialog(context);
          },
        ),
        const SizedBox(height: 24),
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

        const SizedBox(height: 30),
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
