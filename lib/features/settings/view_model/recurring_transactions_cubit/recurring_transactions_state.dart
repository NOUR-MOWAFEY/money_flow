part of 'recurring_transactions_cubit.dart';

@immutable
abstract class RecurringTransactionsState {}

class RecurringTransactionsInitial extends RecurringTransactionsState {}

class RecurringTransactionsLoading extends RecurringTransactionsState {}

class RecurringTransactionsLoaded extends RecurringTransactionsState {
  RecurringTransactionsLoaded({required this.recurringTransactions})
    : active = recurringTransactions.where((t) => t.isActive).toList(),
      inactive = recurringTransactions.where((t) => !t.isActive).toList();

  final List<RecurringTransactionModel> recurringTransactions;
  final List<RecurringTransactionModel> active;
  final List<RecurringTransactionModel> inactive;
}

class RecurringTransactionsFailure extends RecurringTransactionsState {
  RecurringTransactionsFailure(this.errorMessage);

  final String errorMessage;
}
