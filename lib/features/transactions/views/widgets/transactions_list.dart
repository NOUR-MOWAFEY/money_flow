import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_list_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.transactions,
    required this.findCategory,
    this.maxItems = 20,
  });

  final List<TransactionModel> transactions;
  final CategoryModel Function(String title, bool isExpense) findCategory;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final displayedTransactions = transactions.take(maxItems).toList();
    return MultiSliver(
      children: [
        const SliverToBoxAdapter(child: TransactionsListHeader()),

        SliverList.builder(
          itemCount: displayedTransactions.length,
          itemBuilder: (context, index) {
            final transaction = displayedTransactions[index];
            return TransactionTile(
              transactionModel: transaction,
              category: findCategory(transaction.title, transaction.isExpense),
              index: index,
            );
          },
        ),
      ],
    );
  }
}
