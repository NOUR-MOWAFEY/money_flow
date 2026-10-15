import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/category_resolver.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/create_environment_cubit/create_environment_cubit.dart';
import 'package:money_flow/features/environments/view_models/create_environment_cubit/create_environment_state.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';

void main() {
  late Directory tempDir;
  late HiveService service;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('environments_test_');
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

  group('EnvironmentStorageService tests', () {
    test('creates and retrieves environments', () async {
      final env = EnvironmentModel(
        id: 'env_1',
        name: 'Home Shopping',
        description: 'Living room and groceries',
        initialAmount: 500.0,
        currentBalance: 500.0,
        createdAt: DateTime.now(),
      );

      await service.addEnvironment(env);
      final list = service.getEnvironments();

      expect(list.length, 1);
      expect(list.first.name, 'Home Shopping');
      expect(list.first.currentBalance, 500.0);
    });

    test('adding expenses updates environment balance', () async {
      final env = EnvironmentModel(
        id: 'env_2',
        name: 'Trip to Alexandria',
        initialAmount: 1000.0,
        currentBalance: 1000.0,
        createdAt: DateTime.now(),
      );
      await service.addEnvironment(env);

      final expense = EnvironmentExpenseModel(
        id: 'exp_1',
        environmentId: 'env_2',
        title: 'Fuel',
        amount: 250.0,
        date: DateTime.now(),
      );

      await service.environmentStorage.addExpense(expense, env);

      expect(env.currentBalance, 750.0);
      expect(env.spentAmount, 250.0);

      final storedExpenses =
          service.environmentStorage.getExpensesForEnvironment('env_2');
      expect(storedExpenses.length, 1);
      expect(storedExpenses.first.title, 'Fuel');
    });

    test('deleting an expense restores environment balance', () async {
      final env = EnvironmentModel(
        id: 'env_3',
        name: 'Project',
        initialAmount: 300.0,
        currentBalance: 300.0,
        createdAt: DateTime.now(),
      );
      await service.addEnvironment(env);

      final expense = EnvironmentExpenseModel(
        id: 'exp_2',
        environmentId: 'env_3',
        title: 'Tools',
        amount: 100.0,
        date: DateTime.now(),
      );

      await service.environmentStorage.addExpense(expense, env);
      expect(env.currentBalance, 200.0);

      await service.environmentStorage.deleteExpense(expense, env);
      expect(env.currentBalance, 300.0);
      expect(
        service.environmentStorage.getExpensesForEnvironment('env_3').isEmpty,
        isTrue,
      );
    });

    test('updating an expense adjusts environment balance and updates expense', () async {
      final env = EnvironmentModel(
        id: 'env_4',
        name: 'Renovation',
        initialAmount: 500.0,
        currentBalance: 500.0,
        createdAt: DateTime.now(),
      );
      await service.addEnvironment(env);

      final expense = EnvironmentExpenseModel(
        id: 'exp_3',
        environmentId: 'env_4',
        title: 'Paint',
        amount: 100.0,
        date: DateTime.now(),
      );

      await service.environmentStorage.addExpense(expense, env);
      expect(env.currentBalance, 400.0);

      // Increase expense from 100 to 150
      await service.environmentStorage.updateExpense(
        expense,
        env,
        title: 'Premium Paint',
        amount: 150.0,
      );

      expect(env.currentBalance, 350.0);
      expect(expense.title, 'Premium Paint');
      expect(expense.amount, 150.0);

      // Decrease expense from 150 to 80
      await service.environmentStorage.updateExpense(
        expense,
        env,
        amount: 80.0,
      );

      expect(env.currentBalance, 420.0);
      expect(expense.amount, 80.0);
    });
  });

  group('EnvironmentsCubit integration with main ledger', () {
    test('createEnvironment with deductFromMainBalance creates expense transaction',
        () async {
      final cubit = EnvironmentsCubit(service);

      await cubit.createEnvironment(
        name: 'Groceries Pocket',
        initialAmount: 400.0,
        deductFromMainBalance: true,
      );

      final transactions = service.getTransactions();
      expect(transactions.length, 1);
      expect(transactions.first.title, 'Environment: Groceries Pocket');
      expect(transactions.first.amount, 400.0);
      expect(transactions.first.isExpense, isTrue);

      final envs = service.getEnvironments();
      expect(envs.length, 1);
      expect(envs.first.currentBalance, 400.0);

      await cubit.close();
    });

    test('settleAndCloseEnvironment returns remainder to main balance as income',
        () async {
      final cubit = EnvironmentsCubit(service);

      await cubit.createEnvironment(
        name: 'Shopping',
        initialAmount: 500.0,
        deductFromMainBalance: true,
      );

      final env = service.getEnvironments().first;
      // Record an expense of 350
      final exp = EnvironmentExpenseModel(
        id: 'exp_shop_1',
        environmentId: env.id,
        title: 'Clothes',
        amount: 350.0,
        date: DateTime.now(),
      );
      await service.environmentStorage.addExpense(exp, env);
      expect(env.currentBalance, 150.0);

      // Settle and return remainder
      await cubit.settleAndCloseEnvironment(
        environment: env,
        returnRemainderToMain: true,
      );

      final allTransactions = service.getTransactions();
      expect(allTransactions.length, 2);

      final refund = allTransactions.firstWhere((t) => !t.isExpense);
      expect(refund.title, 'Remaining from Shopping');
      expect(refund.amount, 150.0);
      expect(refund.isExpense, isFalse);

      expect(env.isClosed, isTrue);

      await cubit.close();
    });

    test('CategoryResolver resolves environment icon and color for remaining transaction',
        () async {
      final env = EnvironmentModel(
        id: 'env_shop',
        name: 'Shopping',
        initialAmount: 200.0,
        currentBalance: 50.0,
        createdAt: DateTime.now(),
        colorValue: 0xFFE91E8C,
        iconCodePoint: 0xe59c, // shopping_bag
      );
      await service.addEnvironment(env);

      final resolved = service.environmentStorage.getEnvironments();
      expect(resolved.isNotEmpty, isTrue);

      final categoryModel = CategoryResolver.findCategory(
        title: 'Remaining from Shopping',
        isExpense: false,
        allCategories: [],
      );

      expect(categoryModel.icon.codePoint, 0xe59c);
      expect(categoryModel.color, const Color(0xFFE91E8C));
    });
  });

  group('CreateEnvironmentCubit tests', () {
    test('initializes with default color, icon, and deductFromMain', () {
      final cubit = CreateEnvironmentCubit(service);
      expect(cubit.deductFromMain, isTrue);
      expect(cubit.selectedColor, isNotNull);
      expect(cubit.selectedIcon, isNotNull);
      cubit.close();
    });

    test('selectColor and selectIcon update cubit state', () {
      final cubit = CreateEnvironmentCubit(service);
      cubit.selectColor(Colors.teal);
      expect(cubit.selectedColor, Colors.teal);

      cubit.toggleDeductFromMain(false);
      expect(cubit.deductFromMain, isFalse);
      cubit.close();
    });

    test('createEnvironment creates environment and records transaction when deduct is true',
        () async {
      final cubit = CreateEnvironmentCubit(service);
      cubit.nameController.text = 'Vacation Fund';
      cubit.descController.text = 'Trip budget';
      cubit.amountController.text = '750';
      cubit.deductFromMain = true;

      await cubit.createEnvironment();

      expect(cubit.state, isA<CreateEnvironmentSuccess>());
      final envs = service.getEnvironments();
      expect(envs.length, 1);
      expect(envs.first.name, 'Vacation Fund');
      expect(envs.first.initialAmount, 750.0);

      final txs = service.getTransactions();
      expect(txs.length, 1);
      expect(txs.first.title, 'Environment: Vacation Fund');
      expect(txs.first.amount, 750.0);
      expect(txs.first.environmentId, envs.first.id);
      expect(txs.first.isEnvironmentLinked, isTrue);

      await cubit.close();
    });

    test('edit environment updates existing environment data without duplicating transaction',
        () async {
      final env = EnvironmentModel(
        id: 'env_to_edit',
        name: 'Old Name',
        description: 'Old Description',
        initialAmount: 500.0,
        currentBalance: 500.0,
        createdAt: DateTime.now(),
        colorValue: 0xFF123456,
        iconCodePoint: 0xe3ae,
        deductedFromMain: false,
      );
      await service.addEnvironment(env);

      final cubit = CreateEnvironmentCubit(service, environment: env);
      expect(cubit.isEditing, isTrue);
      expect(cubit.nameController.text, 'Old Name');
      expect(cubit.descController.text, 'Old Description');
      expect(cubit.amountController.text, '500');
      expect(cubit.deductFromMain, isFalse);

      cubit.nameController.text = 'Updated Name';
      cubit.descController.text = 'Updated Description';
      cubit.amountController.text = '600';

      await cubit.saveEnvironment();

      expect(cubit.state, isA<CreateEnvironmentSuccess>());
      final updatedState = cubit.state as CreateEnvironmentSuccess;
      expect(updatedState.isEditing, isTrue);
      expect(updatedState.environmentName, 'Updated Name');

      final updatedEnv = service.getEnvironment('env_to_edit');
      expect(updatedEnv, isNotNull);
      expect(updatedEnv!.name, 'Updated Name');
      expect(updatedEnv.description, 'Updated Description');
      expect(updatedEnv.initialAmount, 600.0);
      expect(updatedEnv.currentBalance, 600.0);

      // Verify no extra ledger transaction created on edit
      final txs = service.getTransactions();
      expect(txs.isEmpty, isTrue);

      await cubit.close();
    });

    test(
        'deleteEnvironment unlocks linked transaction in main balance so user can delete it',
        () async {
      final envsCubit = EnvironmentsCubit(service);

      await envsCubit.createEnvironment(
        name: 'Weekend Vacation',
        initialAmount: 700.0,
        deductFromMainBalance: true,
      );

      final env = service.getEnvironments().first;
      final tx = service.getTransactions().first;
      expect(tx.environmentId, env.id);
      expect(tx.isEnvironmentActive(service), isTrue);

      // Delete the environment
      await envsCubit.deleteEnvironment(env);

      // Environment is deleted
      expect(service.getEnvironment(env.id), isNull);

      // Transaction is now unlocked (isEnvironmentActive is false)
      expect(tx.isEnvironmentActive(service), isFalse);

      // User can now delete the transaction from the main ledger
      await service.deleteTransaction(tx);
      expect(service.getTransactions().isEmpty, isTrue);

      await envsCubit.close();
    });

    test(
        'deleteEnvironment with deleteTransactions: true cascades deletion to main balance',
        () async {
      final envsCubit = EnvironmentsCubit(service);

      await envsCubit.createEnvironment(
        name: 'Car Repair',
        initialAmount: 450.0,
        deductFromMainBalance: true,
      );

      final env = service.getEnvironments().first;
      expect(service.getTransactions().length, 1);

      // Delete environment with cascade delete of transactions
      await envsCubit.deleteEnvironment(env, deleteTransactions: true);

      expect(service.getEnvironment(env.id), isNull);
      expect(service.getTransactions().isEmpty, isTrue);

      await envsCubit.close();
    });
  });
}


