import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/settle_environment_dialog.dart';

void main() {
  final testEnv = EnvironmentModel(
    id: 'test_env_1',
    name: 'Trip Fund',
    description: 'Vacation spending',
    initialAmount: 500,
    currentBalance: 200,
    createdAt: DateTime(2025, 1, 1),
    colorValue: Colors.blue.toARGB32(),
    iconCodePoint: Icons.flight.codePoint,
    deductedFromMain: true,
  );

  testWidgets('SettleEnvironmentDialog renders as AlertDialog with header and buttons',
      (tester) async {
    bool? confirmed;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogOpenAnimation(
                    child: SettleEnvironmentDialog(
                      environment: testEnv,
                      onConfirm: (val) => confirmed = val,
                    ),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Settle & Close'), findsOneWidget);
    expect(find.textContaining('Are you sure you want to complete "Trip Fund"?'),
        findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Settle'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);

    // Tap Settle and verify confirm callback
    await tester.tap(find.text('Settle'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });

  testWidgets('SettleEnvironmentDialog cancels cleanly without calling onConfirm',
      (tester) async {
    bool? confirmed;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogOpenAnimation(
                    child: SettleEnvironmentDialog(
                      environment: testEnv,
                      onConfirm: (val) => confirmed = val,
                    ),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(confirmed, isNull);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets(
      'SettleEnvironmentRemainderCheckbox toggles value when clicking on the card',
      (tester) async {
    bool? confirmed;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogOpenAnimation(
                    child: SettleEnvironmentDialog(
                      environment: testEnv,
                      onConfirm: (val) => confirmed = val,
                    ),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    final checkboxFinder = find.byType(Checkbox);
    expect(tester.widget<Checkbox>(checkboxFinder).value, isTrue);

    // Tap on the text description within the card (not the Checkbox itself)
    await tester.tap(find.textContaining('Return remaining'));
    await tester.pumpAndSettle();

    // Checkbox should now be false (unchecked)
    expect(tester.widget<Checkbox>(checkboxFinder).value, isFalse);

    // Tap again on the card to toggle back to true
    await tester.tap(find.textContaining('Records an Income transaction'));
    await tester.pumpAndSettle();

    expect(tester.widget<Checkbox>(checkboxFinder).value, isTrue);

    // Tap Settle and verify confirm callback received true
    await tester.tap(find.text('Settle'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });
}

