import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_state.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class EnvironmentsCubit extends Cubit<EnvironmentsState> {
  EnvironmentsCubit(this.hiveService) : super(EnvironmentsInitial()) {
    _envSubscription = hiveService.watchEnvironments().listen((_) {
      loadEnvironments();
    });
    _expensesSubscription = hiveService.watchEnvironmentExpenses().listen((_) {
      loadEnvironments();
    });
    loadEnvironments();
  }

  final HiveService hiveService;
  StreamSubscription? _envSubscription;
  StreamSubscription? _expensesSubscription;

  void loadEnvironments() {
    try {
      final list = hiveService.getEnvironments();
      emit(EnvironmentsSuccess(list));
    } catch (e) {
      emit(EnvironmentsFailure('Failed to load environments'));
    }
  }

  Future<void> createEnvironment({
    required String name,
    String description = '',
    required double initialAmount,
    required bool deductFromMainBalance,
    int? colorValue,
    int? iconCodePoint,
  }) async {
    try {
      final env = EnvironmentModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name.trim(),
        description: description.trim(),
        initialAmount: initialAmount,
        currentBalance: initialAmount,
        createdAt: DateTime.now(),
        colorValue: colorValue ?? 0xFF0B6098,
        iconCodePoint: iconCodePoint ?? 0xe3ae,
        deductedFromMain: deductFromMainBalance && initialAmount > 0,
      );

      await hiveService.addEnvironment(env);

      if (deductFromMainBalance && initialAmount > 0) {
        final transaction = TransactionModel(
          title: 'Environment: ${env.name}',
          amount: initialAmount,
          date: DateTime.now(),
          isExpense: true,
          environmentId: env.id,
        );
        await hiveService.transactionStorage.addTransaction(transaction);
      }

      loadEnvironments();
    } catch (_) {
      emit(EnvironmentsFailure('Failed to create environment'));
    }
  }

  Future<void> settleAndCloseEnvironment({
    required EnvironmentModel environment,
    required bool returnRemainderToMain,
  }) async {
    try {
      if (returnRemainderToMain && environment.currentBalance > 0) {
        final refund = TransactionModel(
          title: 'Remaining from ${environment.name}',
          amount: environment.currentBalance,
          date: DateTime.now(),
          isExpense: false,
          environmentId: environment.id,
        );
        await hiveService.transactionStorage.addTransaction(refund);
      }

      await hiveService.environmentStorage.closeEnvironment(environment);
      loadEnvironments();
    } catch (_) {
      emit(EnvironmentsFailure('Failed to close environment'));
    }
  }

  Future<void> deleteEnvironment(
    EnvironmentModel environment, {
    bool deleteTransactions = false,
  }) async {
    try {
      await hiveService.deleteEnvironment(
        environment.id,
        deleteTransactions: deleteTransactions,
      );
      loadEnvironments();
    } catch (_) {
      emit(EnvironmentsFailure('Failed to delete environment'));
    }
  }

  @override
  Future<void> close() {
    _envSubscription?.cancel();
    _expensesSubscription?.cancel();
    return super.close();
  }
}
