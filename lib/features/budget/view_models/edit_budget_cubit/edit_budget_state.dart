part of 'edit_budget_cubit.dart';

@immutable
abstract class EditBudgetState {}

class EditBudgetInitial extends EditBudgetState {}

class EditBudgetLoading extends EditBudgetState {}

class EditBudgetSuccess extends EditBudgetState {}

class EditBudgetFailure extends EditBudgetState {
  EditBudgetFailure(this.message);

  final String message;
}
