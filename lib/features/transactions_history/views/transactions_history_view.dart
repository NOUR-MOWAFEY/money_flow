import 'package:flutter/material.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_view_body.dart';

class TransactionsHistoryView extends StatelessWidget {
  const TransactionsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: TransactionsHistoryViewBody());
  }
}
