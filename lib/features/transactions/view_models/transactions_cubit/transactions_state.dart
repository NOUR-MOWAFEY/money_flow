part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {
  final List<TransactionModel> transactions;
  final List<CategoryModel> allCategories;
  final double balance;

  TransactionsSuccess(this.transactions, this.allCategories)
    : balance = transactions.fold(0, (sum, transaction) {
        return transaction.isExpense
            ? sum - transaction.amount
            : sum + transaction.amount;
      });

  /// Finds the matching category for a transaction by title and type.
  /// Falls back to [AppCategories.defaultCategory] if none found.
  CategoryModel findCategory(String title, bool isExpense) {
    final targetType =
        isExpense ? CategoryType.expenses : CategoryType.income;
    return allCategories.firstWhere(
      (c) => c.title == title && c.categoryType == targetType,
      orElse: () => AppCategories.defaultCategory,
    );
  }
}

class TransactionsFailure extends TransactionsState {
  final String message;
  TransactionsFailure(this.message);
}
