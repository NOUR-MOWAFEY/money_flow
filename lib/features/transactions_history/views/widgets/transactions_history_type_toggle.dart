import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_type_filter.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';

class TransactionsHistoryTypeToggle extends StatelessWidget {
  const TransactionsHistoryTypeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsHistoryCubit, TransactionsHistoryState>(
      buildWhen: (prev, current) {
        if (current is TransactionsHistorySuccess &&
            prev is TransactionsHistorySuccess) {
          return prev.filter.typeFilter != current.filter.typeFilter;
        }
        return true;
      },
      builder: (context, state) {
        final currentFilter = state is TransactionsHistorySuccess
            ? state.filter.typeFilter
            : TransactionTypeFilter.all;

        return Center(
          child: CustomToggleSwitch<TransactionTypeFilter>(
            current: currentFilter,
            values: TransactionTypeFilter.values,
            itemLabelBuilder: (item) => item.label,
            onChanged: (selected) {
              context
                  .read<TransactionsHistoryCubit>()
                  .updateTypeFilter(selected);
            },
          ),
        );
      },
    );
  }
}
