import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

void main() {
  late Directory tempDir;
  late HiveService service;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_service_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
    service = HiveService.instance;
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('HiveService openBoxes & Box Names', () {
    test('opens all required boxes', () {
      expect(Hive.isBoxOpen(HiveService.transactionsBoxName), isTrue);
      expect(Hive.isBoxOpen(HiveService.categoriesBoxName), isTrue);
      expect(Hive.isBoxOpen(HiveService.budgetsBoxName), isTrue);
      expect(Hive.isBoxOpen(HiveService.recurringTransactionsBoxName), isTrue);
      expect(Hive.isBoxOpen(HiveService.userBoxName), isTrue);
    });
  });

  group('User Box Operations', () {
    test('isFirstTime is true by default and can be marked false', () async {
      expect(HiveService.isFirstTime, isTrue);

      await HiveService.setNotFirstTime();
      expect(HiveService.isFirstTime, isFalse);
    });

    test('saveUserModel, getUserModel, and currentUser instance getter', () async {
      final user = UserModel(name: 'Alice', defaultCurrency: 'USD');
      await HiveService.saveUserModel(user);

      final retrieved = HiveService.getUserModel();
      expect(retrieved?.name, 'Alice');
      expect(retrieved?.defaultCurrency, 'USD');
      expect(service.currentUser?.name, 'Alice');
    });

    test('updateUserModel modifies existing fields', () async {
      final user = UserModel(name: 'Alice', defaultCurrency: 'USD');
      await HiveService.saveUserModel(user);

      await HiveService.updateUserModel(name: 'Bob', defaultCurrency: 'EUR');
      final updated = HiveService.getUserModel();
      expect(updated?.name, 'Bob');
      expect(updated?.defaultCurrency, 'EUR');
    });

    test('deleteUserModel removes user from box', () async {
      final user = UserModel(name: 'Alice');
      await HiveService.saveUserModel(user);
      expect(HiveService.getUserModel(), isNotNull);

      await HiveService.deleteUserModel();
      expect(HiveService.getUserModel(), isNull);
    });
  });

  group('Transactions Operations', () {
    test('add, getTransactions (sorted descending), and editTransaction', () async {
      final t1 = TransactionModel(
        title: 'Lunch',
        amount: 50,
        isExpense: true,
        date: DateTime(2026, 1, 1),
      );
      final t2 = TransactionModel(
        title: 'Salary',
        amount: 5000,
        isExpense: false,
        date: DateTime(2026, 1, 5),
      );

      await service.addTransaction(t1);
      await service.addTransaction(t2);

      final list = service.getTransactions();
      expect(list.length, 2);
      expect(list.first.title, 'Salary'); // newest first
      expect(list.last.title, 'Lunch');

      await service.editTransaction(t1, amount: 65, title: 'Dinner');
      expect(t1.amount, 65);
      expect(t1.title, 'Dinner');
    });

    test('addTransactions and clearTransactions / reset', () async {
      final list = [
        TransactionModel(title: 'T1', amount: 10, isExpense: true, date: DateTime.now()),
        TransactionModel(title: 'T2', amount: 20, isExpense: true, date: DateTime.now()),
      ];
      await service.addTransactions(list);
      expect(service.getTransactions().length, 2);

      await service.clearTransactions();
      expect(service.getTransactions(), isEmpty);

      await service.addTransactions(list);
      expect(service.getTransactions().length, 2);
      await service.reset();
      expect(service.getTransactions(), isEmpty);
    });

    test('deleteTransaction deletes correctly', () async {
      final t1 = TransactionModel(title: 'T1', amount: 10, isExpense: true, date: DateTime.now());
      await service.addTransaction(t1);
      expect(service.getTransactions().length, 1);

      await service.deleteTransaction(t1);
      expect(service.getTransactions(), isEmpty);
    });
  });

  group('Categories Operations', () {
    test('add, getCategories, and getExpenseCategories', () async {
      final c1 = CategoryModel(
        title: 'Food',
        icon: Icons.fastfood,
        color: Colors.orange,
        categoryType: CategoryType.expenses,
      );
      final c2 = CategoryModel(
        title: 'Salary',
        icon: Icons.attach_money,
        color: Colors.green,
        categoryType: CategoryType.income,
      );

      await service.addCategories([c1, c2]);
      expect(service.getCategories().length, 2);

      final expenseCats = service.getExpenseCategories();
      expect(expenseCats.length, 1);
      expect(expenseCats.first.title, 'Food');
    });

    test('updateCategory renames associated transactions, recurring rules, and budgets', () async {
      final cat = CategoryModel(
        title: 'Groceries',
        icon: Icons.shopping_basket,
        color: Colors.blue,
        categoryType: CategoryType.expenses,
      );
      await service.addCategory(cat);

      final tx = TransactionModel(
        title: 'Groceries',
        amount: 100,
        isExpense: true,
        date: DateTime.now(),
      );
      await service.addTransaction(tx);

      final recurring = RecurringTransactionModel(
        id: 'r1',
        title: 'Groceries',
        categoryTitle: 'Groceries',
        amount: 200,
        type: CategoryType.expenses,
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime.now(),
      );
      await service.addRecurringTransaction(recurring);

      final budget = BudgetModel(
        categoryTitle: 'Groceries',
        limitAmount: 1000,
        period: BudgetPeriod.monthly,
      );
      await service.addBudget(budget);

      await service.updateCategory(cat, title: 'Supermarket');

      expect(tx.title, 'Supermarket');
      expect(recurring.categoryTitle, 'Supermarket');
      expect(budget.categoryTitle, 'Supermarket');
    });

    test('deleteCategory cascades deletedCategory title and deletes budgets', () async {
      final cat = CategoryModel(
        title: 'Cafe',
        icon: Icons.coffee,
        color: Colors.brown,
        categoryType: CategoryType.expenses,
      );
      await service.addCategory(cat);

      final tx = TransactionModel(
        title: 'Cafe',
        amount: 30,
        isExpense: true,
        date: DateTime.now(),
      );
      await service.addTransaction(tx);

      final budget = BudgetModel(
        categoryTitle: 'Cafe',
        limitAmount: 200,
        period: BudgetPeriod.monthly,
      );
      await service.addBudget(budget);

      await service.deleteCategory(cat);

      expect(tx.title, AppCategories.deletedCategory.title);
      expect(service.hasBudgetForCategory('Cafe'), isFalse);
    });
  });

  group('Budgets Operations', () {
    test('add, getBudgets by period, hasBudgetForCategory, update and delete', () async {
      final b1 = BudgetModel(
        categoryTitle: 'Entertainment',
        limitAmount: 500,
        period: BudgetPeriod.monthly,
      );
      final b2 = BudgetModel(
        categoryTitle: 'Coffee',
        limitAmount: 100,
        period: BudgetPeriod.weekly,
      );
      await service.addBudgets([b1, b2]);

      expect(service.getBudgets().length, 2);
      expect(service.getBudgets(BudgetPeriod.monthly).length, 1);
      expect(service.getBudgets(BudgetPeriod.weekly).length, 1);
      expect(service.hasBudgetForCategory('Coffee'), isTrue);
      expect(service.hasBudgetForCategory('NonExistent'), isFalse);

      await service.updateBudget(b1, limitAmount: 600);
      expect(b1.limitAmount, 600);

      await service.deleteBudget(b1);
      expect(service.getBudgets().length, 1);

      await service.clearBudgets();
      expect(service.getBudgets(), isEmpty);
    });
  });

  group('Recurring Transactions Operations', () {
    test('add, get, update, toggle, delete, clear', () async {
      final r1 = RecurringTransactionModel(
        id: 'rec1',
        title: 'Gym',
        categoryTitle: 'Health',
        amount: 50,
        type: CategoryType.expenses,
        frequency: RecurrenceFrequency.monthly,
        startDate: DateTime(2026, 1, 1),
        isActive: true,
      );
      await service.addRecurringTransaction(r1);

      final list = service.getRecurringTransactions();
      expect(list.length, 1);
      expect(list.first.title, 'Gym');

      await service.toggleRecurringTransaction(r1);
      expect(r1.isActive, isFalse);

      await service.updateRecurringTransaction(r1, amount: 60);
      expect(r1.amount, 60);

      await service.deleteRecurringTransaction(r1);
      expect(service.getRecurringTransactions(), isEmpty);

      await service.addRecurringTransactions([
        RecurringTransactionModel(
          id: 'rec2',
          title: 'Internet',
          categoryTitle: 'Bills',
          amount: 80,
          type: CategoryType.expenses,
          frequency: RecurrenceFrequency.monthly,
          startDate: DateTime.now(),
        ),
      ]);
      expect(service.getRecurringTransactions().length, 1);
      await service.clearRecurringTransactions();
      expect(service.getRecurringTransactions(), isEmpty);
    });
  });

  group('Direct Domain Storage Services Usage', () {
    test('UserStorageService works independently', () async {
      const userStorage = UserStorageService();
      await userStorage.saveUserModel(UserModel(name: 'IndependentUser'));
      expect(userStorage.getUserModel()?.name, 'IndependentUser');
      expect(userStorage.isFirstTime, isTrue);
      await userStorage.deleteUserModel();
      expect(userStorage.getUserModel(), isNull);
    });

    test('TransactionStorageService works independently', () async {
      const txStorage = TransactionStorageService();
      final tx = TransactionModel(
        title: 'Snack',
        amount: 5,
        isExpense: true,
        date: DateTime.now(),
      );
      await txStorage.addTransaction(tx);
      expect(txStorage.getTransactions().length, 1);
      await txStorage.clearTransactions();
      expect(txStorage.getTransactions(), isEmpty);
    });

    test('BudgetStorageService works independently', () async {
      const budgetStorage = BudgetStorageService();
      final b = BudgetModel(
        categoryTitle: 'Dining',
        limitAmount: 150,
        period: BudgetPeriod.monthly,
      );
      await budgetStorage.addBudget(b);
      expect(budgetStorage.hasBudgetForCategory('Dining'), isTrue);
      await budgetStorage.clearBudgets();
      expect(budgetStorage.getBudgets(), isEmpty);
    });
  });
}
