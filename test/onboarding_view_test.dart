import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/features/onboarding/views/onboarding_view.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('onboarding_view_test_');
    Hive.init(tempDir.path);
    await Hive.openBox('user');
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets(
      'OnboardingView renders cleanly and animates split button on next', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: OnboardingView(),
      ),
    );
    await tester.pumpAndSettle();

    // Page 0: Full width Next button, no back button visible
    expect(find.text('MoneyFlow'), findsOneWidget);
    expect(find.text('Track Every Penny'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);

    // Back button should have width 0 in AnimatedContainer on page 0
    final backFinder = find.byIcon(Icons.arrow_back_ios_new_rounded);
    expect(backFinder, findsOneWidget);

    // Tap Next to navigate to Page 1
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Page 1: Slide 2 is active, Next button is visible
    expect(find.text('Set Smart Budgets'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Tap Back button to animate back to Page 0
    await tester.tap(backFinder);
    await tester.pumpAndSettle();

    expect(find.text('Track Every Penny'), findsOneWidget);

    // Tap Skip to go to final setup step
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Personalize Your App'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Default Currency'), findsOneWidget);
  });
}
