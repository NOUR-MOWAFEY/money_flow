import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_date_header.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_tile.dart';

class TransactionsHistoryList extends StatelessWidget {
  const TransactionsHistoryList({
    super.key,
    required this.groupedTransactions,
    required this.findCategory,
  });

  final Map<DateTime, List<TransactionModel>> groupedTransactions;
  final CategoryModel Function(String title, bool isExpense) findCategory;

  @override
  Widget build(BuildContext context) {
    final entries = groupedTransactions.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: entries.map((entry) {
        final date = entry.key;
        final transactions = entry.value;

        final dayTotal = transactions.fold(
          0.0,
          (sum, t) => t.isExpense ? sum - t.amount : sum + t.amount,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionsHistoryDateHeader(date: date, dayTotal: dayTotal),
            ...transactions.map((transaction) {
              final category = findCategory(
                transaction.title,
                transaction.isExpense,
              );
              return TransactionsHistoryTile(
                transactionModel: transaction,
                category: category,
              );
            }),
          ],
        );
      }).toList(),
    );
  }
}
