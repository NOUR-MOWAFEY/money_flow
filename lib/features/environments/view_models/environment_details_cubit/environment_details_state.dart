import 'package:flutter/foundation.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';

@immutable
abstract class EnvironmentDetailsState {}

class EnvironmentDetailsInitial extends EnvironmentDetailsState {}

class EnvironmentDetailsLoading extends EnvironmentDetailsState {}

class EnvironmentDetailsSuccess extends EnvironmentDetailsState {
  final EnvironmentModel environment;
  final List<EnvironmentExpenseModel> expenses;

  EnvironmentDetailsSuccess({
    required this.environment,
    required this.expenses,
  });

  double get totalSpent =>
      expenses.fold(0.0, (sum, e) => sum + e.amount);
}

class EnvironmentDetailsFailure extends EnvironmentDetailsState {
  final String message;
  EnvironmentDetailsFailure(this.message);
}
