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
    // Use a date in the past so we can pick a different day within the month.
    final initialDate = DateTime(2024, 1, 10);
    final date = ValueNotifier(initialDate);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: DateField(date: date))),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Tap a different day (e.g. '15') that is visible in the month view.
    // '15' is guaranteed to be in January 2024 and ≤ today.
    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(date.value, DateTime(2024, 1, 15));
    expect(date.value, isNot(initialDate));
  });
}
