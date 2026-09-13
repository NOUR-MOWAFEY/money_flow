import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile.dart';
import 'package:money_flow/features/transactions/views/widgets/transactions_list.dart';

void main() {
  CategoryModel dummyFinder(String title, bool isExpense) =>
      AppCategories.defaultCategory;

  testWidgets('TransactionsList caps items to maxItems (default 20)', (tester) async {
    // Generate 35 transactions
    final items = List.generate(
      35,
      (i) => TransactionModel(
        title: 'Item $i',
        amount: (i + 1) * 10.0,
        isExpense: true,
        date: DateTime(2026, 1, 1).add(Duration(days: i)),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              TransactionsList(
                transactions: items,
                findCategory: dummyFinder,
              ),
            ],
          ),
        ),
      ),
    );

    // Should only build at most 20 tiles
    final tiles = find.byType(TransactionTile);
    expect(tiles.evaluate().length, lessThanOrEqualTo(20));

    // Test with explicit maxItems of 5
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              TransactionsList(
                transactions: items,
                findCategory: dummyFinder,
                maxItems: 5,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(TransactionTile), findsNWidgets(5));
  });
}
