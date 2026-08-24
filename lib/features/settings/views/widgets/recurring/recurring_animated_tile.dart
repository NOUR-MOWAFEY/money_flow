import 'package:flutter/material.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transaction_tile.dart';

class RecurringAnimatedTile extends StatelessWidget {
  const RecurringAnimatedTile({
    super.key,
    required this.recurringTransaction,
  });

  final RecurringTransactionModel recurringTransaction;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 380),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: RecurringTransactionTile(
        key: ValueKey(recurringTransaction.isActive),
        recurringTransaction: recurringTransaction,
      ),
    );
  }
}
