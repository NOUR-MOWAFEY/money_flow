import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/home/views/widgets/environment_balance_item_header.dart';
import 'package:money_flow/features/home/views/widgets/environment_balance_progress_bar.dart';

class EnvironmentBalanceItemCard extends StatelessWidget {
  const EnvironmentBalanceItemCard({
    super.key,
    required this.environment,
    required this.currency,
    required this.isHidden,
    required this.onTap,
  });

  final EnvironmentModel environment;
  final String currency;
  final bool isHidden;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final envColor = Color(environment.colorValue);
    final isClosed = environment.isClosed;

    final spentText = isHidden
        ? '$currency ••••••'
        : '$currency ${environment.spentAmount.toStringAsFixed(2)}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.black1,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isClosed
                  ? Colors.white.withValues(alpha: 0.05)
                  : envColor.withValues(alpha: 0.28),
              width: 1.1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EnvironmentBalanceItemHeader(
                environment: environment,
                currency: currency,
                isHidden: isHidden,
              ),
              const SizedBox(height: 12),
              EnvironmentBalanceProgressBar(
                progress: environment.progress,
                spentText: spentText,
                envColor: envColor,
                isClosed: isClosed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
