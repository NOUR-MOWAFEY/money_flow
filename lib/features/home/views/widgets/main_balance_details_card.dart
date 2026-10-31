import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/stat_metric_item.dart';
import 'package:money_flow/features/home/views/widgets/main_balance_header.dart';
import 'package:money_flow/features/home/views/widgets/main_balance_history_footer.dart';

class MainBalanceDetailsCard extends StatelessWidget {
  const MainBalanceDetailsCard({
    super.key,
    required this.mainBalance,
    required this.currency,
    required this.totalIncome,
    required this.totalExpense,
    required this.transactionCount,
    required this.isHidden,
    this.onTapHistory,
  });

  final double mainBalance;
  final String currency;
  final double totalIncome;
  final double totalExpense;
  final int transactionCount;
  final bool isHidden;
  final VoidCallback? onTapHistory;

  @override
  Widget build(BuildContext context) {
    final balanceText = isHidden
        ? '$currency ••••••'
        : '${mainBalance < 0 ? '-' : ''}$currency ${mainBalance.abs().toStringAsFixed(2)}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainBalanceHeader(),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              balanceText,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: mainBalance < 0 ? AppColors.error : AppColors.text,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: StatMetricItem(
                  label: 'Total Inflow',
                  value: isHidden
                      ? '••••••'
                      : '+$currency ${totalIncome.toStringAsFixed(2)}',
                  color: Colors.green,
                  icon: Icons.arrow_downward_rounded,
                ),
              ),
              Container(
                height: 36,
                width: 1,
                color: Colors.white10,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              Expanded(
                child: StatMetricItem(
                  label: 'Total Outflow',
                  value: isHidden
                      ? '••••••'
                      : '-$currency ${totalExpense.toStringAsFixed(2)}',
                  color: Colors.redAccent,
                  icon: Icons.arrow_upward_rounded,
                ),
              ),
            ],
          ),
          if (onTapHistory != null) ...[
            const SizedBox(height: 14),
            const Divider(color: Colors.white10, height: 1),
            const SizedBox(height: 10),
            MainBalanceHistoryFooter(
              transactionCount: transactionCount,
              onTap: onTapHistory!,
            ),
          ],
        ],
      ),
    );
  }
}
