import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/services/recurring_processor_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(this.hiveService) : super(TransactionsInitial()) {
    _categoriesSubscription = hiveService.watchCategories().listen((_) {
      _reload();
    });
    _transactionsSubscription = hiveService.watchTransactions().listen((_) {
      _reload();
    });
  }

  final HiveService hiveService;
  StreamSubscription? _categoriesSubscription;
  StreamSubscription? _transactionsSubscription;

  void _reload() {
    try {
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions, _buildAllCategories()));
    } catch (e) {
      emit(
        TransactionsFailure('Failed to load transactions, Please try again'),
      );
    }
  }

  //get all transactions
  Future<void> getAllTransactions() async {
    emit(TransactionsLoading());
    try {
      await RecurringProcessorService.instance
          .processDueRecurringTransactions(hiveService);
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions, _buildAllCategories()));
    } catch (e) {
      emit(
        TransactionsFailure('Failed to load transactions, Please try again'),
      );
    }
  }

  // add transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    emit(TransactionsLoading());
    try {
      await hiveService.addTransaction(transaction);
      final transactions = hiveService.getTransactions();

      emit(TransactionsSuccess(transactions, _buildAllCategories()));
      log('Done');
      log(transactions.toString());
    } catch (e) {
      emit(TransactionsFailure('Failed to add transaction, Please try again'));
    }
  }

  //delete transaction
  Future<void> deleteTransaction(TransactionModel transaction) async {
    emit(TransactionsLoading());
    try {
      await hiveService.deleteTransaction(transaction);
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions, _buildAllCategories()));
    } catch (e) {
      emit(
        TransactionsFailure('Failed to delete transaction, Please try again'),
      );
    }
  }

  //edit transaction
  Future<void> editTransaction(
    TransactionModel transaction, {
    String? title,
    double? amount,
    bool? isExpense,
    DateTime? date,
  }) async {
    emit(TransactionsLoading());
    try {
      await hiveService.editTransaction(
        transaction,
        title: title,
        amount: amount,
        isExpense: isExpense,
        date: date,
      );
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions, _buildAllCategories()));
    } catch (e) {
      log(e.toString());
      emit(TransactionsFailure('Failed to edit transaction, Please try again'));
    }
  }

  // clear transactions
  Future<void> clearTransactions() async {
    emit(TransactionsLoading());
    try {
      await hiveService.reset();
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions, _buildAllCategories()));
    } catch (e) {
      emit(
        TransactionsFailure(
          'Failed to delete all transactions, Please try again',
        ),
      );
    }
  }

  /// Builds the full category list once: predefined + user-created from Hive.
  List<CategoryModel> _buildAllCategories() {
    final userCategories = hiveService.getCategories();
    return [
      ...AppCategories.expenseCategories,
      ...AppCategories.incomeCategories,
      ...userCategories,
    ];
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
