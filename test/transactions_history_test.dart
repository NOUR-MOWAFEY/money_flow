import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_date_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_history_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_sort_option.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_type_filter.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';

class FakeHiveService implements HiveService {
  List<TransactionModel> transactions = [];
  List<CategoryModel> categories = [];

  final _transactionsController = StreamController<BoxEvent>.broadcast();
  final _categoriesController = StreamController<BoxEvent>.broadcast();

  @override
  Stream<BoxEvent> watchTransactions() => _transactionsController.stream;

  @override
  Stream<BoxEvent> watchCategories() => _categoriesController.stream;

  @override
  List<TransactionModel> getTransactions() => List.from(transactions);

  @override
  List<CategoryModel> getCategories() => List.from(categories);

  @override
  Future<void> deleteTransaction(TransactionModel transaction) async {
    transactions.removeWhere((t) => t == transaction);
    _transactionsController.add(BoxEvent(null, null, false));
  }

  void dispose() {
    _transactionsController.close();
    _categoriesController.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('TransactionHistoryFilter Model Tests', () {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 12);
    final yesterday = today.subtract(const Duration(days: 1));
    final lastMonth = DateTime(now.year, now.month - 1, 15);

    final expenseItem = TransactionModel(
      title: 'Groceries',
      amount: 150.0,
      isExpense: true,
      date: today,
    );

    final incomeItem = TransactionModel(
      title: 'Salary',
      amount: 5000.0,
      isExpense: false,
      date: yesterday,
    );

    final oldExpenseItem = TransactionModel(
      title: 'Coffee',
      amount: 25.0,
      isExpense: true,
      date: lastMonth,
    );

    test('default filter matches all transactions', () {
      const filter = TransactionHistoryFilter.initial;
      expect(filter.isFiltered, false);
      expect(filter.matches(expenseItem), true);
      expect(filter.matches(incomeItem), true);
      expect(filter.matches(oldExpenseItem), true);
    });

    test('search query matches title and amount', () {
      final titleFilter = const TransactionHistoryFilter().copyWith(
        searchQuery: 'groce',
      );
      expect(titleFilter.matches(expenseItem), true);
      expect(titleFilter.matches(incomeItem), false);

      final amountFilter = const TransactionHistoryFilter().copyWith(
        searchQuery: '5000',
      );
      expect(amountFilter.matches(incomeItem), true);
      expect(amountFilter.matches(expenseItem), false);
    });

    test('type filter filters expense vs income', () {
      final expenseFilter = const TransactionHistoryFilter().copyWith(
        typeFilter: TransactionTypeFilter.expenses,
      );
      expect(expenseFilter.matches(expenseItem), true);
      expect(expenseFilter.matches(incomeItem), false);

      final incomeFilter = const TransactionHistoryFilter().copyWith(
        typeFilter: TransactionTypeFilter.income,
      );
      expect(incomeFilter.matches(expenseItem), false);
      expect(incomeFilter.matches(incomeItem), true);
    });

    test('date filter matches today, thisMonth, customRange', () {
      final todayFilter = const TransactionHistoryFilter().copyWith(
        dateFilter: TransactionDateFilter.today,
      );
      expect(todayFilter.matches(expenseItem), true);
      expect(todayFilter.matches(yesterdayItem(yesterday)), false);

      final customFilter = const TransactionHistoryFilter().copyWith(
        dateFilter: TransactionDateFilter.custom,
        customDateRange: DateTimeRange(
          start: today.subtract(const Duration(days: 2)),
          end: today.add(const Duration(days: 1)),
        ),
      );
      expect(customFilter.matches(expenseItem), true);
      expect(customFilter.matches(incomeItem), true);
      expect(customFilter.matches(oldExpenseItem), false);
    });

    test('sort option comparator orders correctly', () {
      final list = [expenseItem, incomeItem, oldExpenseItem];

      // Date Desc (newest first)
      list.sort(TransactionSortOption.dateDesc.compare);
      expect(list.first.title, 'Groceries');

      // Amount Desc
      list.sort(TransactionSortOption.amountDesc.compare);
      expect(list.first.title, 'Salary');
      expect(list.last.title, 'Coffee');

      // Amount Asc
      list.sort(TransactionSortOption.amountAsc.compare);
      expect(list.first.title, 'Coffee');
    });
  });

  group('TransactionsHistoryCubit Tests', () {
    late FakeHiveService fakeHiveService;
    late TransactionsHistoryCubit cubit;

    final t1 = TransactionModel(
      title: 'Supermarket',
      amount: 200,
      isExpense: true,
      date: DateTime.now(),
    );
    final t2 = TransactionModel(
      title: 'Bonus',
      amount: 1000,
      isExpense: false,
      date: DateTime.now().subtract(const Duration(hours: 2)),
    );

    setUp(() {
      fakeHiveService = FakeHiveService();
      fakeHiveService.transactions = [t1, t2];
      cubit = TransactionsHistoryCubit(fakeHiveService);
    });

    tearDown(() {
      cubit.close();
      fakeHiveService.dispose();
    });

    test('loadTransactions emits TransactionsHistorySuccess with correct stats', () {
      cubit.loadTransactions();
      final state = cubit.state;
      expect(state, isA<TransactionsHistorySuccess>());
      final success = state as TransactionsHistorySuccess;
      expect(success.filteredTransactions.length, 2);
      expect(success.totalIncome, 1000);
      expect(success.totalExpense, 200);
      expect(success.netBalance, 800);
    });

    test('updateTypeFilter updates filtered items', () {
      cubit.loadTransactions();
      cubit.updateTypeFilter(TransactionTypeFilter.expenses);
      final state = cubit.state as TransactionsHistorySuccess;
      expect(state.filteredTransactions.length, 1);
      expect(state.filteredTransactions.first.title, 'Supermarket');
      expect(state.totalExpense, 200);
      expect(state.totalIncome, 0);
    });

    test('updateSearchQuery filters items by text', () {
      cubit.loadTransactions();
      cubit.updateSearchQuery('bonus');
      final state = cubit.state as TransactionsHistorySuccess;
      expect(state.filteredTransactions.length, 1);
      expect(state.filteredTransactions.first.title, 'Bonus');
    });

    test('resetFilters restores initial state', () {
      cubit.loadTransactions();
      cubit.updateTypeFilter(TransactionTypeFilter.income);
      cubit.updateSearchQuery('random');
      expect((cubit.state as TransactionsHistorySuccess).filteredTransactions.isEmpty, true);

      cubit.resetFilters();
      final state = cubit.state as TransactionsHistorySuccess;
      expect(state.filteredTransactions.length, 2);
      expect(state.filter.isFiltered, false);
    });

    test('deleteTransaction removes transaction and updates state', () async {
      cubit.loadTransactions();
      await cubit.deleteTransaction(t1);
      final state = cubit.state as TransactionsHistorySuccess;
      expect(state.filteredTransactions.length, 1);
      expect(state.filteredTransactions.first.title, 'Bonus');
    });
  });
}

TransactionModel yesterdayItem(DateTime yesterday) => TransactionModel(
  title: 'Yesterday item',
  amount: 50,
  isExpense: true,
  date: yesterday,
);
