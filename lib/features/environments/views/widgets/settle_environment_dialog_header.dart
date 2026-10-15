import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class SettleEnvironmentDialogHeader extends StatelessWidget {
  const SettleEnvironmentDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: 70,
          color: Colors.green,
        ),
        SizedBox(height: 8),
        CustomText(
          'Settle & Close',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
