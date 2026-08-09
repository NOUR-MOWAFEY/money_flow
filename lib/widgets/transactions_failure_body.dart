import 'package:flutter/material.dart';
import 'package:money_flow/widgets/custom_text.dart';

class TransactionsFailureBody extends StatelessWidget {
  const TransactionsFailureBody({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomText(
            message,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
