part of 'edit_recurring_transaction_cubit.dart';

@immutable
abstract class EditRecurringTransactionState {}

class EditRecurringTransactionInitial extends EditRecurringTransactionState {}

class EditRecurringTransactionLoading extends EditRecurringTransactionState {}

class EditRecurringTransactionSuccess extends EditRecurringTransactionState {}

class EditRecurringTransactionFailure extends EditRecurringTransactionState {
  EditRecurringTransactionFailure(this.errorMessage);

  final String errorMessage;
}
