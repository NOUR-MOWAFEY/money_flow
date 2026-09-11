import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_active_chips.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_empty_body.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_failure_body.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_filter_bar.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_header.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_list.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_loading_body.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_search_bar.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_summary_card.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_type_toggle.dart';

class TransactionsHistoryViewBody extends StatelessWidget {
  const TransactionsHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child: ListView(
        children: [
          const TransactionsHistoryHeader(),
          const TransactionsHistorySearchBar(),
          const SizedBox(height: 14),
          const TransactionsHistoryTypeToggle(),
          const SizedBox(height: 14),
          const TransactionsHistoryFilterBar(),
          const TransactionsHistoryActiveChips(),
          BlocBuilder<TransactionsHistoryCubit, TransactionsHistoryState>(
            builder: (context, state) {
              if (state is TransactionsHistoryLoading) {
                return const TransactionsHistoryLoadingBody();
              } else if (state is TransactionsHistoryFailure) {
                return TransactionsHistoryFailureBody(message: state.message);
              } else if (state is TransactionsHistorySuccess) {
                if (state.isEmpty) {
                  return TransactionsHistoryEmptyBody(
                    hasTransactionsInDb: state.hasTransactionsInDb,
                  );
                }
                return Column(
                  children: [
                    TransactionsHistorySummaryCard(
                      totalCount: state.filteredTransactions.length,
                      totalIncome: state.totalIncome,
                      totalExpense: state.totalExpense,
                      netBalance: state.netBalance,
                    ),
                    TransactionsHistoryList(
                      groupedTransactions: state.groupedByDate,
                      findCategory: state.findCategory,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: AppDimensions.viewBottomSpaceWithFlaoting),
        ],
      ),
    );
  }
}