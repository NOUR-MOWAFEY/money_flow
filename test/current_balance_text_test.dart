import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/constants/app_currencies.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';
import 'package:money_flow/features/home/views/widgets/current_balance_text.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_cubit.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('current_balance_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  Widget buildTestWidget({double balance = 150.0}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => BalanceVisibilityCubit(),
          child: CurrentBalanceText(balance: balance),
        ),
      ),
    );
  }

  testWidgets('CurrentBalanceText shows default currency EGP and updates live on currency change', (tester) async {
    await tester.runAsync(() async {
      await HiveService.saveUserModel(
        UserModel(name: 'Test', defaultCurrency: 'EGP', isFirstTime: false),
      );
    });

    await tester.pumpWidget(buildTestWidget(balance: 250.0));
    await tester.pump();

    expect(find.text('EGP 250.00'), findsOneWidget);

    // Change currency to USD via CurrencyPickerCubit inside real async zone
    await tester.runAsync(() async {
      final cubit = CurrencyPickerCubit();
      final usd = AppCurrencies.currencies.firstWhere((c) => c.code == 'USD');
      await cubit.selectCurrency(usd);
      await cubit.close();
      await Future.delayed(const Duration(milliseconds: 50));
    });

    // Pump widget tree to reflect stream update
    await tester.pump();

    // The text on Home View should immediately reflect USD
    expect(find.text('USD 250.00'), findsOneWidget);
    expect(find.text('EGP 250.00'), findsNothing);
  });

  testWidgets('CurrentBalanceText updates currency live even when balance is hidden', (tester) async {
    await tester.runAsync(() async {
      await HiveService.saveUserModel(
        UserModel(name: 'Test', defaultCurrency: 'EUR', isFirstTime: false),
      );
      await HiveService.instance.userStorage.setBalanceHidden(true);
    });

    await tester.pumpWidget(buildTestWidget(balance: 1000.0));
    await tester.pump();

    expect(find.text('EUR ••••••'), findsOneWidget);

    // Update currency to GBP inside real async zone
    await tester.runAsync(() async {
      await HiveService.updateUserModel(defaultCurrency: 'GBP');
      await Future.delayed(const Duration(milliseconds: 50));
    });

    await tester.pump();

    expect(find.text('GBP ••••••'), findsOneWidget);
    expect(find.text('EUR ••••••'), findsNothing);
  });
}
