import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 12),
      sliver: SliverList.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) =>
            TransactionTile(transactionModel: transactions[index]),
      ),
    );
  }
}
