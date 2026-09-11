import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

enum TransactionSortOption {
  dateDesc('Newest First'),
  dateAsc('Oldest First'),
  amountDesc('Highest Amount'),
  amountAsc('Lowest Amount');

  const TransactionSortOption(this.label);

  final String label;

  int compare(TransactionModel a, TransactionModel b) {
    switch (this) {
      case TransactionSortOption.dateDesc:
        return b.date.compareTo(a.date);
      case TransactionSortOption.dateAsc:
        return a.date.compareTo(b.date);
      case TransactionSortOption.amountDesc:
        return b.amount.compareTo(a.amount);
      case TransactionSortOption.amountAsc:
        return a.amount.compareTo(b.amount);
    }
  }
}
