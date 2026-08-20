import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/budget/data/budget_data_helper.dart';
import 'package:money_flow/features/budget/data/models/budget_limit_item.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit(this.hiveService) : super(BudgetInitial()) {
    _transactionsSubscription = hiveService.watchTransactions().listen((_) {
      _reload();
    });
    _budgetsSubscription = hiveService.watchBudgets().listen((_) {
      _reload();
    });
    loadBudgets();
  }

  final HiveService hiveService;
  StreamSubscription? _transactionsSubscription;
  StreamSubscription? _budgetsSubscription;

  ReportPeriod selectedPeriod = ReportPeriod.weekly;

  void loadBudgets() {
    emit(BudgetLoading());
    _reload();
  }

 void changePeriod(ReportPeriod period) {
  if (selectedPeriod == period) return;

  selectedPeriod = period;

  BudgetPeriod? budgetPeriod;

  switch (period) {
    case ReportPeriod.daily:
      budgetPeriod = null;

    case ReportPeriod.weekly:
      budgetPeriod = BudgetPeriod.weekly;

    case ReportPeriod.monthly:
      budgetPeriod = BudgetPeriod.monthly;
  }

  emit(BudgetLoading());
  _reload(budgetPeriod);
}

  void _reload([BudgetPeriod? period]) {
    try {
      final budgets = hiveService.getBudgets(period);
      final transactions = hiveService.getTransactions();
      final items = BudgetDataHelper.buildBudgetItems(
        budgets: budgets,
        transactions: transactions,
        hiveService: hiveService,
      );

      emit(BudgetSuccess(items, period));
    } catch (_) {
      emit(BudgetFailure('Failed to load budgets, Please try again'));
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription?.cancel();
    _budgetsSubscription?.cancel();
    return super.close();
  }
}
