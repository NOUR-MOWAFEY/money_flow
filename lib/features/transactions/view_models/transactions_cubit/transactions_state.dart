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
  CategoryModel findCategory(String title, bool isExpense) {
    return CategoryResolver.findCategory(
      title: title,
      isExpense: isExpense,
      allCategories: allCategories,
    );
  }
}

class TransactionsFailure extends TransactionsState {
  final String message;
  TransactionsFailure(this.message);
}
