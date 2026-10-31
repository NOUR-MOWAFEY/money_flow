import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';
import 'package:money_flow/features/home/views/total_balance_view.dart';
import 'package:money_flow/features/home/views/widgets/home_view_app_bar.dart';
import 'package:money_flow/features/home/views/widgets/main_balance_details_card.dart';
import 'package:money_flow/features/home/views/widgets/total_balance_hero_card.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('total_balance_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  Widget buildHomeBarWithNavigation({
    required TransactionsCubit txCubit,
    required BalanceVisibilityCubit visibilityCubit,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: txCubit),
        BlocProvider.value(value: visibilityCubit),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 90,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: HomeViewAppBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTotalBalanceWidget({
    required TransactionsCubit txCubit,
    required BalanceVisibilityCubit visibilityCubit,
    EnvironmentsCubit? envCubit,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: txCubit),
        BlocProvider.value(value: visibilityCubit),
      ],
      child: MaterialApp(
        home: TotalBalanceView(environmentsCubit: envCubit),
      ),
    );
  }

  testWidgets('Clicking balance in HomeViewAppBar navigates to TotalBalanceView',
      (tester) async {
    final txCubit = TransactionsCubit(HiveService());
    final visibilityCubit = BalanceVisibilityCubit();

    await tester.runAsync(() async {
      await HiveService.saveUserModel(
        UserModel(name: 'Tester', defaultCurrency: 'USD', isFirstTime: false),
      );
      await HiveService.instance.addTransaction(
        TransactionModel(
          title: 'Salary',
          amount: 5000,
          date: DateTime.now(),
          isExpense: false,
        ),
      );
    });

    await txCubit.getAllTransactions();

    await tester.pumpWidget(
      buildHomeBarWithNavigation(
        txCubit: txCubit,
        visibilityCubit: visibilityCubit,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Current Balance'), findsOneWidget);
    expect(find.text('USD 5000.00'), findsOneWidget);

    // Tap on the balance in HomeViewAppBar
    await tester.tap(find.text('Current Balance'));
    await tester.pumpAndSettle();

    // Verify navigation to TotalBalanceView
    expect(find.byType(TotalBalanceView), findsOneWidget);
    expect(find.text('Total Balance'), findsWidgets);

    Navigator.of(tester.element(find.byType(TotalBalanceView))).pop();
    await tester.pumpAndSettle();

    await tester.pumpWidget(const SizedBox());
    await txCubit.close();
    await visibilityCubit.close();
  });

  testWidgets(
      'TotalBalanceView displays total balance (main + all environments) and individual env details',
      (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final txCubit = TransactionsCubit(HiveService());
    final visibilityCubit = BalanceVisibilityCubit();
    final envCubit = EnvironmentsCubit(HiveService.instance);

    await tester.runAsync(() async {
      await HiveService.saveUserModel(
        UserModel(name: 'Tester', defaultCurrency: 'EUR', isFirstTime: false),
      );

      // Add main ledger transactions
      await HiveService.instance.addTransaction(
        TransactionModel(
          title: 'Salary',
          amount: 3000,
          date: DateTime.now(),
          isExpense: false,
        ),
      );
      await HiveService.instance.addTransaction(
        TransactionModel(
          title: 'Groceries',
          amount: 500,
          date: DateTime.now(),
          isExpense: true,
        ),
      );
      // Main balance = 3000 - 500 = 2500

      // Add active environment 1
      final env1 = EnvironmentModel(
        id: 'env_1',
        name: 'Summer Trip',
        description: 'Vacation savings',
        initialAmount: 1000,
        currentBalance: 800,
        createdAt: DateTime.now(),
        colorValue: 0xFF2196F3,
        iconCodePoint: 0xe3ae,
        deductedFromMain: false,
      );
      await HiveService.instance.addEnvironment(env1);

      // Add active environment 2
      final env2 = EnvironmentModel(
        id: 'env_2',
        name: 'Gadget Fund',
        description: 'New laptop',
        initialAmount: 1200,
        currentBalance: 1200,
        createdAt: DateTime.now(),
        colorValue: 0xFFFF9800,
        iconCodePoint: 0xe3ae,
        deductedFromMain: true,
      );
      await HiveService.instance.addEnvironment(env2);
    });

    await txCubit.getAllTransactions();

    await tester.pumpWidget(
      buildTotalBalanceWidget(
        txCubit: txCubit,
        visibilityCubit: visibilityCubit,
        envCubit: envCubit,
      ),
    );
    await tester.pumpAndSettle();

    // Main balance is 2500.00
    // Env1 is 800.00, Env2 is 1200.00 -> Total Env balance = 2000.00
    // Total Balance = 2500 + 2000 = 4500.00
    expect(
      find.descendant(
        of: find.byType(TotalBalanceHeroCard),
        matching: find.text('EUR 4500.00'),
      ),
      findsOneWidget,
    );

    // Verify Main balance details card shows 2500.00
    expect(
      find.descendant(
        of: find.byType(MainBalanceDetailsCard),
        matching: find.text('EUR 2500.00'),
      ),
      findsOneWidget,
    );
    expect(find.text('Main Ledger Balance'), findsOneWidget);
    expect(find.text('+EUR 3000.00'), findsOneWidget); // Total Inflow
    expect(find.text('-EUR 500.00'), findsOneWidget); // Total Outflow
    expect(find.text('2 transactions recorded'), findsOneWidget);

    // Verify individual environments are listed
    expect(find.text('Summer Trip'), findsOneWidget);
    expect(find.text('EUR 800.00'), findsOneWidget);
    expect(find.text('Vacation savings'), findsOneWidget);

    expect(find.text('Gadget Fund'), findsOneWidget);
    expect(find.text('EUR 1200.00'), findsOneWidget);
    expect(find.text('New laptop'), findsOneWidget);

    // Verify active environments badge
    expect(find.text('2 Active'), findsWidgets);

    await tester.pumpWidget(const SizedBox());
    await txCubit.close();
    await visibilityCubit.close();
    await envCubit.close();
  });

  testWidgets('TotalBalanceView respects BalanceVisibilityCubit toggle',
      (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final txCubit = TransactionsCubit(HiveService());
    final visibilityCubit = BalanceVisibilityCubit();
    final envCubit = EnvironmentsCubit(HiveService.instance);

    await tester.runAsync(() async {
      await HiveService.saveUserModel(
        UserModel(name: 'Tester', defaultCurrency: 'EGP', isFirstTime: false),
      );
      await HiveService.instance.addTransaction(
        TransactionModel(
          title: 'Bonus',
          amount: 1000,
          date: DateTime.now(),
          isExpense: false,
        ),
      );
      await HiveService.instance.addEnvironment(
        EnvironmentModel(
          id: 'env_3',
          name: 'Emergency',
          initialAmount: 500,
          currentBalance: 500,
          createdAt: DateTime.now(),
        ),
      );
    });

    await txCubit.getAllTransactions();

    await tester.pumpWidget(
      buildTotalBalanceWidget(
        txCubit: txCubit,
        visibilityCubit: visibilityCubit,
        envCubit: envCubit,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('EGP 1500.00'), findsOneWidget);
    expect(find.text('EGP 1000.00'), findsNWidgets(2));
    expect(find.text('EGP 500.00'), findsNWidgets(2));

    // Toggle balance visibility inside runAsync for Hive disk persistence
    await tester.runAsync(() async {
      await visibilityCubit.toggle();
    });
    await tester.pumpAndSettle();

    // Expect masked text
    expect(find.text('EGP ••••••'), findsWidgets);
    expect(find.text('EGP 1500.00'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    await txCubit.close();
    await visibilityCubit.close();
    await envCubit.close();
  });
}
