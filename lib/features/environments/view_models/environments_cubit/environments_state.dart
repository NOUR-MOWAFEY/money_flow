import 'package:flutter/foundation.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';

@immutable
abstract class EnvironmentsState {}

class EnvironmentsInitial extends EnvironmentsState {}

class EnvironmentsLoading extends EnvironmentsState {}

class EnvironmentsSuccess extends EnvironmentsState {
  final List<EnvironmentModel> environments;

  EnvironmentsSuccess(this.environments);

  double get totalIsolatedBalance => environments
      .where((e) => !e.isClosed)
      .fold(0.0, (sum, e) => sum + e.currentBalance);

  int get activeCount =>
      environments.where((e) => !e.isClosed).length;

  int get closedCount =>
      environments.where((e) => e.isClosed).length;
}

class EnvironmentsFailure extends EnvironmentsState {
  final String message;
  EnvironmentsFailure(this.message);
}
