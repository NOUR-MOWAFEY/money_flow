import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/view_header.dart';

class TransactionsHistoryHeader extends StatelessWidget {
  const TransactionsHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return canPop
        ? const SizedBox()
        : const ViewHeader(
            title: 'Transactions History',
            subtitle: 'Search, filter, and review all your transactions',
          );
  }
}
