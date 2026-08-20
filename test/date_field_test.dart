import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/features/transactions/views/widgets/date_field.dart';

void main() {
  testWidgets('keeps existing date when date picker is cancelled', (
    WidgetTester tester,
  ) async {
    final storedDate = DateTime(2023, 5, 15);
    final date = ValueNotifier(storedDate);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: DateField(date: date))),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(date.value, storedDate);
  });

  testWidgets('updates date when a new date is picked', (
    WidgetTester tester,
  ) async {
    final date = ValueNotifier(DateTime(2024, 1, 10));

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: DateField(date: date))),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(date.value, isNot(DateTime(2024, 1, 10)));
  });
}
