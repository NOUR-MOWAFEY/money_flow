part of 'transactions_cubit.dart';

@immutable
sealed class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {
  final List<TransactionModel> transactions;
  TransactionsSuccess(this.transactions);
}

class TransactionsFailure extends TransactionsState {
  final String message;
  TransactionsFailure(this.message);
}
