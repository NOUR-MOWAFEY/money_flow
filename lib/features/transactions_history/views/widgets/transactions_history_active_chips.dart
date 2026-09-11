import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_date_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_sort_option.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_type_filter.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';

class TransactionsHistoryActiveChips extends StatelessWidget {
  const TransactionsHistoryActiveChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsHistoryCubit, TransactionsHistoryState>(
      builder: (context, state) {
        if (state is! TransactionsHistorySuccess) {
          return const SizedBox.shrink();
        }

        final filter = state.filter;
        if (!filter.isFiltered) return const SizedBox.shrink();

        final cubit = context.read<TransactionsHistoryCubit>();

        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (filter.typeFilter != TransactionTypeFilter.all)
                  _ActiveChip(
                    label: filter.typeFilter.label,
                    onDeleted: () =>
                        cubit.updateTypeFilter(TransactionTypeFilter.all),
                  ),
                if (filter.dateFilter != TransactionDateFilter.allTime)
                  _ActiveChip(
                    label: filter.dateFilter.label,
                    onDeleted: () =>
                        cubit.updateDateFilter(TransactionDateFilter.allTime),
                  ),
                if (filter.categoryFilter != null)
                  _ActiveChip(
                    label: filter.categoryFilter!,
                    onDeleted: () => cubit.updateCategoryFilter(null),
                  ),
                if (filter.sortOption != TransactionSortOption.dateDesc)
                  _ActiveChip(
                    label: filter.sortOption.label,
                    onDeleted: () =>
                        cubit.updateSortOption(TransactionSortOption.dateDesc),
                  ),
                if (filter.searchQuery.isNotEmpty)
                  _ActiveChip(
                    label: '"${filter.searchQuery}"',
                    onDeleted: () => cubit.updateSearchQuery(''),
                  ),
                TextButton(
                  onPressed: () => cubit.resetFilters(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const CustomText(
                    'Reset All',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip({required this.label, required this.onDeleted});

  final String label;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.only(left: 10, right: 4, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.white),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onDeleted,
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.close, size: 14, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
