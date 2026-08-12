import 'package:flutter/material.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 8),
      sliver: SliverList.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) => TransactionTile(
          transactionModel: transactions[index],
          index: index,
        ),
      ),
    );
  }
}
