import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class RecurringTransactionsEmptyListView extends StatelessWidget {
  const RecurringTransactionsEmptyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.repeat_rounded, size: 64, color: AppColors.grey),

            SizedBox(height: 16),

            CustomText(
              'No Recurring Transactions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            SizedBox(height: 8),

            CustomText(
              'Add subscriptions, rent, salaries, or any regular repeating expenses and income.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
