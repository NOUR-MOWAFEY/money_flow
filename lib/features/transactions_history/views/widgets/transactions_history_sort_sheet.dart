import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_sort_option.dart';

class TransactionsHistorySortSheet extends StatelessWidget {
  const TransactionsHistorySortSheet({
    super.key,
    required this.currentSort,
    required this.onSelected,
  });

  final TransactionSortOption currentSort;
  final ValueChanged<TransactionSortOption> onSelected;

  static Future<void> show(
    BuildContext context, {
    required TransactionSortOption currentSort,
    required ValueChanged<TransactionSortOption> onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => TransactionsHistorySortSheet(
        currentSort: currentSort,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CustomText(
              'Sort Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...TransactionSortOption.values.map((sortOption) {
              final isSelected = currentSort == sortOption;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  _getSortIcon(sortOption),
                  color: isSelected ? AppColors.primary : Colors.white70,
                ),
                title: CustomText(
                  sortOption.label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.primary : Colors.white,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  onSelected(sortOption);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  IconData _getSortIcon(TransactionSortOption option) {
    switch (option) {
      case TransactionSortOption.dateDesc:
        return Icons.calendar_today;
      case TransactionSortOption.dateAsc:
        return Icons.history;
      case TransactionSortOption.amountDesc:
        return Icons.arrow_upward_rounded;
      case TransactionSortOption.amountAsc:
        return Icons.arrow_downward_rounded;
    }
  }
}
