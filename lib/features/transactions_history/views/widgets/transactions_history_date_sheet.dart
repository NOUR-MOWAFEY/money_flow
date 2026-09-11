import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/utils/date_formatter.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_date_filter.dart';

class TransactionsHistoryDateSheet extends StatelessWidget {
  const TransactionsHistoryDateSheet({
    super.key,
    required this.currentFilter,
    this.currentRange,
    required this.onSelected,
  });

  final TransactionDateFilter currentFilter;
  final DateTimeRange? currentRange;
  final void Function(TransactionDateFilter filter, DateTimeRange? range)
  onSelected;

  static Future<void> show(
    BuildContext context, {
    required TransactionDateFilter currentFilter,
    DateTimeRange? currentRange,
    required void Function(TransactionDateFilter filter, DateTimeRange? range)
    onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => TransactionsHistoryDateSheet(
        currentFilter: currentFilter,
        currentRange: currentRange,
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
              'Select Date Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...TransactionDateFilter.values.map((filter) {
              final isSelected = currentFilter == filter;
              String subtitle = '';
              if (filter == TransactionDateFilter.custom &&
                  currentRange != null) {
                subtitle =
                    '${DateFormatter.dmy(currentRange!.start)} - ${DateFormatter.dmy(currentRange!.end)}';
              }

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: CustomText(
                  filter.label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.primary : Colors.white,
                  ),
                ),
                subtitle: subtitle.isNotEmpty
                    ? CustomText(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      )
                    : null,
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : null,
                onTap: () async {
                  if (filter == TransactionDateFilter.custom) {
                    Navigator.pop(context);
                    final pickedRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDateRange: currentRange,
                    );
                    if (pickedRange != null) {
                      onSelected(TransactionDateFilter.custom, pickedRange);
                    }
                  } else {
                    Navigator.pop(context);
                    onSelected(filter, null);
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
