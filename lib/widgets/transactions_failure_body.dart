import 'package:flutter/material.dart';

class TransactionsFailureBody extends StatelessWidget {
  const TransactionsFailureBody({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
