import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/home/views/widgets/total_balance_allocation_bar.dart';
import 'package:money_flow/features/home/views/widgets/total_balance_breakdown_item.dart';
import 'package:money_flow/features/home/views/widgets/total_balance_hero_header.dart';

class TotalBalanceHeroCard extends StatelessWidget {
  const TotalBalanceHeroCard({
    super.key,
    required this.totalBalance,
    required this.mainBalance,
    required this.environmentsBalance,
    required this.currency,
    required this.activeEnvironmentsCount,
    required this.isHidden,
  });

  final double totalBalance;
  final double mainBalance;
  final double environmentsBalance;
  final String currency;
  final int activeEnvironmentsCount;
  final bool isHidden;

  static const Color _environmentsColor = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    final displayText = isHidden
        ? '$currency ••••••'
        : '${totalBalance < 0 ? '-' : ''}$currency ${totalBalance.abs().toStringAsFixed(2)}';

    final positiveMain = mainBalance > 0 ? mainBalance : 0.0;
    final positiveEnv = environmentsBalance > 0 ? environmentsBalance : 0.0;
    final combinedPositive = positiveMain + positiveEnv;

    final double mainRatio = combinedPositive > 0 ? (positiveMain / combinedPositive) : 0.5;
    final double envRatio = combinedPositive > 0 ? (positiveEnv / combinedPositive) : 0.5;

    final String mainPctText = combinedPositive > 0
        ? '${(mainRatio * 100).toStringAsFixed(0)}%'
        : '--';
    final String envPctText = combinedPositive > 0
        ? '${(envRatio * 100).toStringAsFixed(0)}%'
        : '--';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.black1,
            AppColors.black1.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TotalBalanceHeroHeader(
            activeEnvironmentsCount: activeEnvironmentsCount,
          ),
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              displayText,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 18),
          TotalBalanceAllocationBar(
            mainRatio: mainRatio,
            envRatio: envRatio,
            hasPositiveFunds: combinedPositive > 0,
            environmentsColor: _environmentsColor,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TotalBalanceBreakdownItem(
                  dotColor: AppColors.primary,
                  title: 'Main Ledger',
                  percentage: mainPctText,
                  amount: isHidden
                      ? '••••••'
                      : '${mainBalance < 0 ? '-' : ''}$currency ${mainBalance.abs().toStringAsFixed(2)}',
                ),
              ),
              Container(
                height: 36,
                width: 1,
                color: Colors.white.withValues(alpha: 0.08),
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: TotalBalanceBreakdownItem(
                  dotColor: _environmentsColor,
                  title: 'Environments',
                  percentage: envPctText,
                  amount: isHidden
                      ? '••••••'
                      : '$currency ${environmentsBalance.toStringAsFixed(2)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
