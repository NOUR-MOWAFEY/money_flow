import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile_price.dart';

void main() {
  testWidgets('TransactionTilePrice renders red for expense (-)', (tester) async {
    final expense = TransactionModel(
      title: 'Groceries',
      amount: 45.5,
      isExpense: true,
      date: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TransactionTilePrice(transactionModel: expense),
        ),
      ),
    );

    final signText = tester.widget<Text>(find.text('-'));
    expect(signText.style?.color, Colors.red);

    final amountText = tester.widget<Text>(find.text('45.5'));
    expect(amountText.style?.color, Colors.red);
  });

  testWidgets('TransactionTilePrice renders green for income (+)', (tester) async {
    final income = TransactionModel(
      title: 'Salary',
      amount: 3000.0,
      isExpense: false,
      date: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TransactionTilePrice(transactionModel: income),
        ),
      ),
    );

    final signText = tester.widget<Text>(find.text('+'));
    expect(signText.style?.color, Colors.green);

    final amountText = tester.widget<Text>(find.text('3000.0'));
    expect(amountText.style?.color, Colors.green);
  });
}
