import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

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
                    child: _SummaryMetric(
                      label: 'Income',
                      amount: '+$currency ${totalIncome.toStringAsFixed(2)}',
                      color: Colors.green,
                      icon: Icons.arrow_downward_rounded,
                    ),
                  ),
                  Container(width: 1, height: 36, color: Colors.white10),
                  Expanded(
                    child: _SummaryMetric(
                      label: 'Expenses',
                      amount: '-$currency ${totalExpense.toStringAsFixed(2)}',
                      color: Colors.red,
                      icon: Icons.arrow_upward_rounded,
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

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  final String label;
  final String amount;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color.withAlpha(40),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label,
                  style: const TextStyle(fontSize: 11, color: Colors.white54),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    amount,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
