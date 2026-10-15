import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/environment_add_funds_button.dart';
import 'package:money_flow/features/environments/views/widgets/environment_balance_stats_row.dart';

class EnvironmentBalanceHeader extends StatelessWidget {
  const EnvironmentBalanceHeader({
    super.key,
    required this.environment,
    required this.totalSpent,
    this.onAddFunds,
  });

  final EnvironmentModel environment;
  final double totalSpent;
  final VoidCallback? onAddFunds;

  @override
  Widget build(BuildContext context) {
    final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';
    final cardColor = Color(environment.colorValue);
    final isClosed = environment.isClosed;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isClosed
              ? Colors.white.withValues(alpha: 0.08)
              : cardColor.withValues(alpha: 0.4),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                isClosed ? 'Final Balance (Closed)' : 'Current Balance',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isClosed)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const CustomText(
                    'Closed',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else if (onAddFunds != null)
                EnvironmentAddFundsButton(onTap: onAddFunds!),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              '$currency ${environment.currentBalance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isClosed ? Colors.white54 : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: environment.progress,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation<Color>(
                isClosed ? Colors.white24 : cardColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          EnvironmentBalanceStatsRow(
            environment: environment,
            totalSpent: totalSpent,
            currency: currency,
          ),
        ],
      ),
    );
  }
}
