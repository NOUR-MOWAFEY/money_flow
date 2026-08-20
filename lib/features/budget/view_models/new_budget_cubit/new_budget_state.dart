part of 'new_budget_cubit.dart';

@immutable
abstract class NewBudgetState {}

class NewBudgetInitial extends NewBudgetState {}

class NewBudgetLoading extends NewBudgetState {}

class NewBudgetSuccess extends NewBudgetState {}

class NewBudgetFailure extends NewBudgetState {
  NewBudgetFailure(this.message);

  final String message;
}
