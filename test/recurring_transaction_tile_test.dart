import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transaction_tile.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('recurring_tile_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
    await HiveService.saveUserModel(
      UserModel(name: 'Test', defaultCurrency: 'USD', isFirstTime: false),
    );
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets('RecurringTransactionTile renders red for expense (-)', (tester) async {
    final expense = RecurringTransactionModel(
      id: '1',
      title: 'Netflix',
      amount: 15.0,
      type: CategoryType.expenses,
      frequency: RecurrenceFrequency.monthly,
      startDate: DateTime(2026, 1, 1),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecurringTransactionTile(recurringTransaction: expense),
        ),
      ),
    );

    final amountFinder = find.text('- USD 15');
    expect(amountFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(amountFinder);
    expect(textWidget.style?.color, Colors.red);
  });

  testWidgets('RecurringTransactionTile renders green for income (+)', (tester) async {
    final income = RecurringTransactionModel(
      id: '2',
      title: 'Freelance',
      amount: 500.0,
      type: CategoryType.income,
      frequency: RecurrenceFrequency.monthly,
      startDate: DateTime(2026, 1, 1),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecurringTransactionTile(recurringTransaction: income),
        ),
      ),
    );

    final amountFinder = find.text('+ USD 500');
    expect(amountFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(amountFinder);
    expect(textWidget.style?.color, Colors.green);
  });
}
