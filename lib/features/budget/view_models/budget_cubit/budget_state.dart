part of 'budget_cubit.dart';

@immutable
abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetSuccess extends BudgetState {
  BudgetSuccess(this.items, this.period);

  final BudgetPeriod? period;
  final List<BudgetLimitItem> items;
}

class BudgetFailure extends BudgetState {
  BudgetFailure(this.message);

  final String message;
}
