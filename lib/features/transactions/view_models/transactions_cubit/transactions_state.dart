part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {
  final List<TransactionModel> transactions;
  final double balance;
  TransactionsSuccess(this.transactions)
    : balance = transactions.fold(0, (sum, transaction) {
        return transaction.isExpense
            ? sum - transaction.amount
            : sum + transaction.amount;
      });
}

class TransactionsFailure extends TransactionsState {
  final String message;
  TransactionsFailure(this.message);
}
