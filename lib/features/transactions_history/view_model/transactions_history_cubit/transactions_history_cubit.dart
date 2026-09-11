import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_date_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_history_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_sort_option.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_type_filter.dart';

part 'transactions_history_state.dart';

class TransactionsHistoryCubit extends Cubit<TransactionsHistoryState> {
  TransactionsHistoryCubit(this.hiveService)
    : super(TransactionsHistoryInitial()) {
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
  TransactionHistoryFilter _filter = TransactionHistoryFilter.initial;

  TransactionHistoryFilter get currentFilter => _filter;

  void loadTransactions() {
    emit(TransactionsHistoryLoading());
    _reload();
  }

  void updateSearchQuery(String query) {
    _filter = _filter.copyWith(searchQuery: query);
    _reload();
  }

  void updateTypeFilter(TransactionTypeFilter type) {
    _filter = _filter.copyWith(typeFilter: type);
    _reload();
  }

  void updateDateFilter(
    TransactionDateFilter dateFilter, [
    DateTimeRange? customRange,
  ]) {
    _filter = _filter.copyWith(
      dateFilter: dateFilter,
      customDateRange: customRange,
      clearCustomDateRange: customRange == null,
    );
    _reload();
  }

  void updateCategoryFilter(String? categoryTitle) {
    _filter = _filter.copyWith(
      categoryFilter: categoryTitle,
      clearCategoryFilter: categoryTitle == null,
    );
    _reload();
  }

  void updateSortOption(TransactionSortOption sortOption) {
    _filter = _filter.copyWith(sortOption: sortOption);
    _reload();
  }

  void resetFilters() {
    _filter = TransactionHistoryFilter.initial;
    _reload();
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    try {
      await hiveService.deleteTransaction(transaction);
      _reload();
    } catch (_) {
      emit(
        TransactionsHistoryFailure(
          'Failed to delete transaction. Please try again.',
        ),
      );
    }
  }

  void _reload() {
    try {
      final allTransactions = hiveService.getTransactions();
      final allCategories = _buildAllCategories();

      final filtered = allTransactions
          .where((transaction) => _filter.matches(transaction))
          .toList()
        ..sort((a, b) => _filter.sortOption.compare(a, b));

      emit(
        TransactionsHistorySuccess(
          allTransactions: allTransactions,
          filteredTransactions: filtered,
          allCategories: allCategories,
          filter: _filter,
        ),
      );
    } catch (_) {
      emit(
        TransactionsHistoryFailure(
          'Failed to load transactions history. Please try again.',
        ),
      );
    }
  }

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
