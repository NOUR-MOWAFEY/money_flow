import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class BudgetFailureBody extends StatelessWidget {
  const BudgetFailureBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Center(
        child: CustomText(
          message,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
