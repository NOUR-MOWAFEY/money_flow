part of 'transactions_history_cubit.dart';

@immutable
abstract class TransactionsHistoryState {}

class TransactionsHistoryInitial extends TransactionsHistoryState {}

class TransactionsHistoryLoading extends TransactionsHistoryState {}

class TransactionsHistorySuccess extends TransactionsHistoryState {
  TransactionsHistorySuccess({
    required this.allTransactions,
    required this.filteredTransactions,
    required this.allCategories,
    required this.filter,
  }) : totalIncome = filteredTransactions
           .where((t) => !t.isExpense)
           .fold(0.0, (sum, t) => sum + t.amount),
       totalExpense = filteredTransactions
           .where((t) => t.isExpense)
           .fold(0.0, (sum, t) => sum + t.amount),
       netBalance = filteredTransactions.fold(
         0.0,
         (sum, t) => t.isExpense ? sum - t.amount : sum + t.amount,
       );

  final List<TransactionModel> allTransactions;
  final List<TransactionModel> filteredTransactions;
  final List<CategoryModel> allCategories;
  final TransactionHistoryFilter filter;

  final double totalIncome;
  final double totalExpense;
  final double netBalance;

  bool get isEmpty => filteredTransactions.isEmpty;
  bool get hasTransactionsInDb => allTransactions.isNotEmpty;

  /// Finds the matching category for a transaction by title and type.
  CategoryModel findCategory(String title, bool isExpense) {
    final targetType =
        isExpense ? CategoryType.expenses : CategoryType.income;
    return allCategories.firstWhere(
      (c) => c.title == title && c.categoryType == targetType,
      orElse: () => AppCategories.defaultCategory,
    );
  }

  /// Groups filtered transactions by normalized calendar date (year, month, day).
  Map<DateTime, List<TransactionModel>> get groupedByDate {
    final Map<DateTime, List<TransactionModel>> groups = {};
    for (final transaction in filteredTransactions) {
      final dateKey = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );
      groups.putIfAbsent(dateKey, () => []).add(transaction);
    }
    return groups;
  }
}

class TransactionsHistoryFailure extends TransactionsHistoryState {
  TransactionsHistoryFailure(this.message);
  final String message;
}
