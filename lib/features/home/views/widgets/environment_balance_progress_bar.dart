import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class EnvironmentBalanceProgressBar extends StatelessWidget {
  const EnvironmentBalanceProgressBar({
    super.key,
    required this.progress,
    required this.spentText,
    required this.envColor,
    required this.isClosed,
  });

  final double progress;
  final String spentText;
  final Color envColor;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    final percentRemaining = (progress * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation<Color>(
              isClosed ? Colors.white24 : envColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Spent: $spentText',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white38,
              ),
            ),
            CustomText(
              '$percentRemaining% remaining',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isClosed ? Colors.white38 : envColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
