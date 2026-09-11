import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_date_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_sort_option.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_category_sheet.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_date_sheet.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_sort_sheet.dart';

class TransactionsHistoryFilterBar extends StatelessWidget {
  const TransactionsHistoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsHistoryCubit, TransactionsHistoryState>(
      builder: (context, state) {
        if (state is! TransactionsHistorySuccess) {
          return const SizedBox.shrink();
        }

        final cubit = context.read<TransactionsHistoryCubit>();
        final filter = state.filter;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Date Filter Button
              _FilterChip(
                icon: Icons.calendar_month_outlined,
                label: filter.dateFilter == TransactionDateFilter.allTime
                    ? 'Date'
                    : filter.dateFilter.label,
                isActive: filter.dateFilter != TransactionDateFilter.allTime,
                onTap: () => TransactionsHistoryDateSheet.show(
                  context,
                  currentFilter: filter.dateFilter,
                  currentRange: filter.customDateRange,
                  onSelected: (dateFilter, range) =>
                      cubit.updateDateFilter(dateFilter, range),
                ),
              ),
              const SizedBox(width: 8),

              // Category Filter Button
              _FilterChip(
                icon: Icons.category_outlined,
                label: filter.categoryFilter ?? 'Category',
                isActive: filter.categoryFilter != null,
                onTap: () => TransactionsHistoryCategorySheet.show(
                  context,
                  categories: state.allCategories,
                  selectedCategory: filter.categoryFilter,
                  onSelected: (category) => cubit.updateCategoryFilter(category),
                ),
              ),
              const SizedBox(width: 8),

              // Sort Option Button
              _FilterChip(
                icon: Icons.swap_vert_rounded,
                label: filter.sortOption.label,
                isActive: filter.sortOption != TransactionSortOption.dateDesc,
                onTap: () => TransactionsHistorySortSheet.show(
                  context,
                  currentSort: filter.sortOption,
                  onSelected: (sortOption) =>
                      cubit.updateSortOption(sortOption),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withAlpha(50)
              : AppColors.black1,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.white12,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? AppColors.primary : Colors.white70,
            ),
            const SizedBox(width: 6),
            CustomText(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? Colors.white : Colors.white70,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: isActive ? AppColors.primary : Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}
