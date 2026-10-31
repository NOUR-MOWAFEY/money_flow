import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/stat_metric_item.dart';

class TransactionsHistorySummaryCard extends StatelessWidget {
  const TransactionsHistorySummaryCard({
    super.key,
    required this.totalCount,
    required this.totalIncome,
    required this.totalExpense,
    required this.netBalance,
  });

  final int totalCount;
  final double totalIncome;
  final double totalExpense;
  final double netBalance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, _) {
        final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.black1,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    '$totalCount ${totalCount == 1 ? 'transaction' : 'transactions'} found',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  Row(
                    children: [
                      const CustomText(
                        'Net: ',
                        style: TextStyle(fontSize: 12, color: Colors.white54),
                      ),
                      CustomText(
                        '${netBalance >= 0 ? '+' : '-'}$currency ${netBalance.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: netBalance >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white10, height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatMetricItem(
                      label: 'Income',
                      value: '+$currency ${totalIncome.toStringAsFixed(2)}',
                      color: Colors.green,
                      icon: Icons.arrow_downward_rounded,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  Container(width: 1, height: 36, color: Colors.white10),
                  Expanded(
                    child: StatMetricItem(
                      label: 'Expenses',
                      value: '-$currency ${totalExpense.toStringAsFixed(2)}',
                      color: Colors.red,
                      icon: Icons.arrow_upward_rounded,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
