import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/settings/views/add_recurring_transactions_view.dart';

class CustomAddRecurringButton extends StatelessWidget {
  const CustomAddRecurringButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddRecurringTransactionsView(),
          ),
        ),
        icon: const Icon(
          Icons.add_rounded,
          size: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.icon,
        ),
      ),
    );
  }
}
