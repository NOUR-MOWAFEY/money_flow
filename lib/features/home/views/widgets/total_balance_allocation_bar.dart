import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class TotalBalanceAllocationBar extends StatelessWidget {
  const TotalBalanceAllocationBar({
    super.key,
    required this.mainRatio,
    required this.envRatio,
    required this.hasPositiveFunds,
    this.environmentsColor = const Color(0xFF10B981),
  });

  final double mainRatio;
  final double envRatio;
  final bool hasPositiveFunds;
  final Color environmentsColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 8,
        width: double.infinity,
        color: Colors.white.withValues(alpha: 0.08),
        child: hasPositiveFunds
            ? Row(
                children: [
                  Flexible(
                    flex: (mainRatio * 1000).toInt().clamp(1, 1000),
                    child: Container(color: AppColors.primary),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    flex: (envRatio * 1000).toInt().clamp(1, 1000),
                    child: Container(color: environmentsColor),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
