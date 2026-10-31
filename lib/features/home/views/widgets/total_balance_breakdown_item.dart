import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class TotalBalanceBreakdownItem extends StatelessWidget {
  const TotalBalanceBreakdownItem({
    super.key,
    required this.dotColor,
    required this.title,
    required this.percentage,
    required this.amount,
  });

  final Color dotColor;
  final String title;
  final String percentage;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: CustomText(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                ),
                maxLines: 1,
              ),
            ),
            CustomText(
              percentage,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white38,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(
            amount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
