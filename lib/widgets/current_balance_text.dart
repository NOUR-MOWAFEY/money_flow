import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CurrentBalanceText extends StatelessWidget {
  const CurrentBalanceText({super.key, this.balance = 0, this.text});
  final double balance;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text == null ? 'EGP ${balance.toStringAsFixed(2)}' : text!,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }
}
