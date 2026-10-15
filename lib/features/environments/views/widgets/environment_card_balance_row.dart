import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class EnvironmentCardBalanceRow extends StatelessWidget {
  const EnvironmentCardBalanceRow({
    super.key,
    required this.currency,
    required this.currentBalance,
    required this.initialAmount,
    required this.isClosed,
  });

  final String currency;
  final double currentBalance;
  final double initialAmount;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              'Remaining',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 2),
            CustomText(
              '$currency ${currentBalance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isClosed ? Colors.white54 : Colors.white,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CustomText(
              'Allocated',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 2),
            CustomText(
              '$currency ${initialAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
