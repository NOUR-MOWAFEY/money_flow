import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';

class TransactionsHistoryFailureBody extends StatelessWidget {
  const TransactionsHistoryFailureBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            CustomText(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Retry',
              width: 140,
              onTap: () {
                context.read<TransactionsHistoryCubit>().loadTransactions();
              },
            ),
          ],
        ),
      ),
    );
  }
}
