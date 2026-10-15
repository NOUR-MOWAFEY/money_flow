import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/views/widgets/add_transaction_view_body.dart';
import 'package:money_flow/features/transactions/views/widgets/category_field.dart';
import 'package:money_flow/features/transactions/views/widgets/edit_transaction_view_body.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cat_field_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets(
    'CategoryField renders 1 line for short title and wraps to 2 lines for long title',
    (WidgetTester tester) async {
      final shortCat = CategoryModel(
        title: 'Food',
        icon: Icons.fastfood,
        color: Colors.red,
        categoryType: CategoryType.expenses,
      );
      final longCat = CategoryModel(
        title: 'Very Long Category Name That Exceeds One Line Easily On Mobile Devices',
        icon: Icons.fastfood,
        color: Colors.red,
        categoryType: CategoryType.expenses,
      );

      final categoryNotifier = ValueNotifier<CategoryModel?>(shortCat);
      final typeNotifier = ValueNotifier<CategoryType>(CategoryType.expenses);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: CategoryField(
                category: categoryNotifier,
                transactionType: typeNotifier,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final shortFinder = find.text('Food');
      expect(shortFinder, findsOneWidget);
      final shortRenderBox = tester.renderObject(shortFinder) as RenderBox;
      expect(shortRenderBox.size.height, lessThan(20.0));

      // Switch to long category title
      categoryNotifier.value = longCat;
      await tester.pumpAndSettle();

      final longFinder = find.text(longCat.title);
      expect(longFinder, findsOneWidget);
      final longRenderBox = tester.renderObject(longFinder) as RenderBox;
      // Multi-line height should be at least 2 lines (>= 28 px)
      expect(longRenderBox.size.height, greaterThanOrEqualTo(24.0));
    },
  );

  testWidgets(
    'EditTransactionViewBody toggle switch matches AddTransactionViewBody width',
    (WidgetTester tester) async {
      final cubit = TransactionsCubit(HiveService.instance);

      // 1. Render AddTransactionViewBody and measure toggle width
      await tester.pumpWidget(
        BlocProvider<TransactionsCubit>.value(
          value: cubit,
          child: const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 400,
                height: 800,
                child: AddTransactionViewBody(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final addToggleFinder = find.byType(CustomToggleSwitch<CategoryType>);
      expect(addToggleFinder, findsOneWidget);
      final addToggleSize = tester.getSize(addToggleFinder);

      // 2. Render EditTransactionViewBody and measure toggle width
      final transaction = TransactionModel(
        title: 'Food',
        amount: 150,
        date: DateTime.now(),
        isExpense: true,
      );

      await tester.pumpWidget(
        BlocProvider<TransactionsCubit>.value(
          value: cubit,
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 400,
                height: 800,
                child: EditTransactionViewBody(transactionModel: transaction),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final editToggleFinder = find.byType(CustomToggleSwitch<CategoryType>);
      expect(editToggleFinder, findsOneWidget);
      final editToggleSize = tester.getSize(editToggleFinder);

      // Both should have identical width (400 - 2 * 20 = 360)
      expect(editToggleSize.width, equals(addToggleSize.width));
      expect(editToggleSize.width, equals(360.0));

      await cubit.close();
    },
  );
}
