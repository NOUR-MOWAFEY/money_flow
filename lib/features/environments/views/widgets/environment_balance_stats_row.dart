import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/environment_stat_item.dart';

class EnvironmentBalanceStatsRow extends StatelessWidget {
  const EnvironmentBalanceStatsRow({
    super.key,
    required this.environment,
    required this.totalSpent,
    required this.currency,
  });

  final EnvironmentModel environment;
  final double totalSpent;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final cardColor = Color(environment.colorValue);
    final isClosed = environment.isClosed;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EnvironmentStatItem(
          label: 'Allocated',
          value: '$currency ${environment.initialAmount.toStringAsFixed(2)}',
        ),
        EnvironmentStatItem(
          label: 'Spent',
          value: '$currency ${totalSpent.toStringAsFixed(2)}',
          valueColor: AppColors.error,
        ),
        EnvironmentStatItem(
          label: 'Remaining',
          value: '$currency ${environment.currentBalance.toStringAsFixed(2)}',
          valueColor: isClosed ? Colors.white54 : cardColor,
        ),
      ],
    );
  }
}
