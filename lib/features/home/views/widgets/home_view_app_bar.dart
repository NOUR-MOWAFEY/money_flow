import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/home/views/widgets/current_balance_text.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(
          'Current Balance',
          style: TextStyle(fontSize: 14, color: AppColors.bg),
        ),

        BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsSuccess) {
              return CurrentBalanceText(balance: state.balance);
            } else if (state is TransactionsFailure) {
              return const CurrentBalanceText(text: 'Failed to load balance');
            }
            return const CurrentBalanceText(text: 'Loading...');
          },
        ),
      ],
    );
  }
}
