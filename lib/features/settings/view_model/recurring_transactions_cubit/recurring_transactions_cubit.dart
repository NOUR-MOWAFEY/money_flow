import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/services/recurring_processor_service.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';

part 'recurring_transactions_state.dart';

class RecurringTransactionsCubit extends Cubit<RecurringTransactionsState> {
  RecurringTransactionsCubit(this.hiveService)
    : super(RecurringTransactionsInitial()) {
    _subscription = hiveService.watchRecurringTransactions().listen((_) {
      getRecurringTransactions();
    });
    getRecurringTransactions();
  }

  final HiveService hiveService;
  StreamSubscription? _subscription;

  void getRecurringTransactions() {
    emit(RecurringTransactionsLoading());
    try {
      final transactions = hiveService.getRecurringTransactions();
      emit(RecurringTransactionsLoaded(recurringTransactions: transactions));
    } catch (_) {
      emit(
        RecurringTransactionsFailure(
          'Failed to load recurring transactions, Please try again',
        ),
      );
    }
  }

  Future<void> toggleStatus(RecurringTransactionModel recurring) async {
    try {
      await hiveService.toggleRecurringTransaction(recurring);
      if (recurring.isActive) {
        await RecurringProcessorService.instance
            .processDueRecurringTransactions(hiveService);
      }
    } catch (_) {
      emit(
        RecurringTransactionsFailure(
          'Failed to update status, Please try again',
        ),
      );
    }
  }

  Future<void> deleteRecurring(RecurringTransactionModel recurring) async {
    try {
      await hiveService.deleteRecurringTransaction(recurring);
    } catch (_) {
      emit(
        RecurringTransactionsFailure(
          'Failed to delete recurring transaction, Please try again',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
