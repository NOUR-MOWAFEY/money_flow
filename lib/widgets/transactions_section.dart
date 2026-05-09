import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/cubits/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/widgets/transactions_failure_body.dart';
import 'package:money_flow/widgets/transactions_list.dart';
import 'package:money_flow/widgets/transactions_loading_body.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        DecoratedSliver(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          sliver: BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsSuccess) {
                return TransactionsList(transactions: state.transactions);
              } else if (state is TransactionsFailure) {
                return TransactionsFailureBody(message: state.message);
              }
              return const TransactionsLoadingBody();
            },
          ),
        ),

        const SliverFillRemaining(
          hasScrollBody: false,
          child: ColoredBox(
            color: AppColors.white,
            child: SizedBox(height: 20),
          ),
        ),
      ],
    );
  }
}
