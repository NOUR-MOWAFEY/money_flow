import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.transactions,
    required this.findCategory,
  });

  final List<TransactionModel> transactions;
  final CategoryModel Function(String title, bool isExpense) findCategory;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 8),
      sliver: SliverList.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return TransactionTile(
            transactionModel: transaction,
            category: findCategory(transaction.title, transaction.isExpense),
            index: index,
          );
        },
      ),
    );
  }
}
