import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions/views/add_transaction_view.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';

class TransactionsHistoryEmptyBody extends StatelessWidget {
  const TransactionsHistoryEmptyBody({
    super.key,
    required this.hasTransactionsInDb,
  });

  final bool hasTransactionsInDb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.black1,
              child: Icon(
                hasTransactionsInDb
                    ? Icons.filter_alt_off_outlined
                    : Icons.receipt_long_outlined,
                size: 36,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              hasTransactionsInDb
                  ? 'No matching transactions'
                  : 'No transactions yet',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomText(
              hasTransactionsInDb
                  ? 'Try changing your filters or search keywords'
                  : 'Add your first transaction to see your history here',
              style: const TextStyle(fontSize: 13, color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (hasTransactionsInDb)
              CustomButton(
                title: 'Reset Filters',
                width: 160,
                onTap: () {
                  context.read<TransactionsHistoryCubit>().resetFilters();
                },
              )
            else
              CustomButton(
                title: 'Add Transaction',
                width: 180,
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => const AddTransactionView(),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
