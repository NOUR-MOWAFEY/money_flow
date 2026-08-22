import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_failure_body.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_list.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_loading_body.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        DecoratedSliver(
          decoration: const BoxDecoration(
            color: AppColors.black1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          sliver: BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              if (state is TransactionsSuccess) {
                return state.transactions.isEmpty
                    ? const SliverToBoxAdapter(child: SizedBox(height: 50))
                    : TransactionsList(
                        transactions: state.transactions,
                        findCategory: state.findCategory,
                      );
              } else if (state is TransactionsFailure) {
                return TransactionsFailureBody(message: state.message);
              }
              return const TransactionsLoadingBody();
            },
          ),
        ),

        const SliverFillRemaining(
          hasScrollBody: false,
          child: SizedBox(
            height: AppDimensions.viewBottomSpaceWithFlaoting,
            child: ColoredBox(color: AppColors.black1),
          ),
        ),
      ],
    );
  }
}
