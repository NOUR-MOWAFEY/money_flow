import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/data/models/budget_limit_item.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';

class BudgetLimitTile extends StatelessWidget {
  const BudgetLimitTile({
    super.key,
    required this.item,
    this.onTap,
  });

  final BudgetLimitItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = item.statusColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CategoryIcon(icon: item.icon, color: item.iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: _CategoryInfo(
                  title: item.title,
                  spent: item.spent,
                  limit: item.limit,
                  period: item.period,
                ),
              ),
              _PercentageBadge(percentage: item.percentage, color: color),
            ],
          ),
          const SizedBox(height: 10),
          _ProgressBar(progress: item.progress, color: color),
        ],
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.icon, this.color});

  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}

class _CategoryInfo extends StatelessWidget {
  const _CategoryInfo({
    required this.title,
    required this.spent,
    required this.limit,
    required this.period,
  });

  final String title;
  final double spent;
  final double limit;
  final BudgetPeriod period;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          'EGP ${spent.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)} • ${period.title}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}

class _PercentageBadge extends StatelessWidget {
  const _PercentageBadge({required this.percentage, required this.color});

  final int percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: CustomText(
        '$percentage%',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
