part of 'new_recurring_transaction_cubit.dart';

@immutable
abstract class NewRecurringTransactionState {}

class NewRecurringTransactionInitial extends NewRecurringTransactionState {}

class NewRecurringTransactionLoading extends NewRecurringTransactionState {}

class NewRecurringTransactionSuccess extends NewRecurringTransactionState {}

class NewRecurringTransactionFailure extends NewRecurringTransactionState {
  NewRecurringTransactionFailure(this.errorMessage);

  final String errorMessage;
}
