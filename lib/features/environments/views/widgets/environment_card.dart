import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/environment_card_balance_row.dart';
import 'package:money_flow/features/environments/views/widgets/environment_card_header.dart';

class EnvironmentCard extends StatelessWidget {
  const EnvironmentCard({
    super.key,
    required this.environment,
    required this.onTap,
    this.onLongPress,
  });

  final EnvironmentModel environment;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';
    final cardColor = Color(environment.colorValue);
    final isClosed = environment.isClosed;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.black1,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isClosed
                  ? Colors.white.withValues(alpha: 0.05)
                  : cardColor.withValues(alpha: 0.35),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EnvironmentCardHeader(environment: environment),
              const SizedBox(height: 16),
              EnvironmentCardBalanceRow(
                currency: currency,
                currentBalance: environment.currentBalance,
                initialAmount: environment.initialAmount,
                isClosed: isClosed,
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: environment.progress,
                  minHeight: 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isClosed ? Colors.white24 : cardColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
