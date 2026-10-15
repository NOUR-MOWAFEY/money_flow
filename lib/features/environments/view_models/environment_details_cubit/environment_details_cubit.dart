import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_state.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class EnvironmentDetailsCubit extends Cubit<EnvironmentDetailsState> {
  EnvironmentDetailsCubit({
    required this.hiveService,
    required this.environmentId,
  }) : super(EnvironmentDetailsInitial()) {
    _expensesSubscription =
        hiveService.watchEnvironmentExpenses().listen((_) {
      loadDetails();
    });
    _envSubscription = hiveService.watchEnvironments().listen((_) {
      loadDetails();
    });
    loadDetails();
  }

  final HiveService hiveService;
  final String environmentId;
  StreamSubscription? _expensesSubscription;
  StreamSubscription? _envSubscription;

  void loadDetails() {
    try {
      final env = hiveService.getEnvironment(environmentId);
      if (env == null) {
        emit(EnvironmentDetailsFailure('Environment not found'));
        return;
      }
      final expenses =
          hiveService.environmentStorage.getExpensesForEnvironment(
            environmentId,
          );
      emit(
        EnvironmentDetailsSuccess(
          environment: env,
          expenses: expenses,
        ),
      );
    } catch (_) {
      emit(EnvironmentDetailsFailure('Failed to load environment details'));
    }
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    DateTime? date,
  }) async {
    final currentState = state;
    if (currentState is! EnvironmentDetailsSuccess) return;

    try {
      final expense = EnvironmentExpenseModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        environmentId: environmentId,
        title: title.trim(),
        amount: amount,
        date: date ?? DateTime.now(),
      );

      await hiveService.environmentStorage.addExpense(
        expense,
        currentState.environment,
      );
      loadDetails();
    } catch (_) {
      emit(EnvironmentDetailsFailure('Failed to add expense'));
    }
  }

  Future<void> deleteExpense(EnvironmentExpenseModel expense) async {
    final currentState = state;
    if (currentState is! EnvironmentDetailsSuccess) return;

    try {
      await hiveService.environmentStorage.deleteExpense(
        expense,
        currentState.environment,
      );
      loadDetails();
    } catch (_) {
      emit(EnvironmentDetailsFailure('Failed to delete expense'));
    }
  }

  Future<void> updateExpense({
    required EnvironmentExpenseModel expense,
    required String title,
    required double amount,
    DateTime? date,
  }) async {
    final currentState = state;
    if (currentState is! EnvironmentDetailsSuccess) return;

    try {
      await hiveService.environmentStorage.updateExpense(
        expense,
        currentState.environment,
        title: title.trim(),
        amount: amount,
        date: date,
      );
      loadDetails();
    } catch (_) {
      emit(EnvironmentDetailsFailure('Failed to update expense'));
    }
  }

  Future<void> topUp({
    required double amount,
    required bool deductFromMainBalance,
  }) async {
    final currentState = state;
    if (currentState is! EnvironmentDetailsSuccess) return;

    try {
      await hiveService.environmentStorage.topUpEnvironment(
        currentState.environment,
        amount,
      );

      if (deductFromMainBalance && amount > 0) {
        final tx = TransactionModel(
          title: 'Top-up: ${currentState.environment.name}',
          amount: amount,
          date: DateTime.now(),
          isExpense: true,
          environmentId: currentState.environment.id,
        );
        await hiveService.transactionStorage.addTransaction(tx);
      }

      loadDetails();
    } catch (_) {
      emit(EnvironmentDetailsFailure('Failed to add funds'));
    }
  }

  @override
  Future<void> close() {
    _expensesSubscription?.cancel();
    _envSubscription?.cancel();
    return super.close();
  }
}
