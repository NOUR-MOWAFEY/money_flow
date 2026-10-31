import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class TotalBalanceHeroHeader extends StatelessWidget {
  const TotalBalanceHeroHeader({
    super.key,
    required this.activeEnvironmentsCount,
  });

  final int activeEnvironmentsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Total Balance',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
            CustomText(
              'Main Ledger + Environments',
              style: TextStyle(fontSize: 11, color: Colors.white38),
            ),
          ],
        ),
      ],
    );
  }
}
