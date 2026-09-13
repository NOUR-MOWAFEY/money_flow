import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';

void main() {
  late Directory tempDir;

  setUpAll(() {
    HiveService.registerAdapters();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('balance_visibility_test_');
    Hive.init(tempDir.path);
    await HiveService.openBoxes();
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('BalanceVisibilityCubit defaults to false (visible) and toggles correctly', () async {
    final cubit = BalanceVisibilityCubit();
    expect(cubit.state, isFalse);

    await cubit.toggle();
    expect(cubit.state, isTrue);
    expect(HiveService.instance.userStorage.isBalanceHidden, isTrue);

    await cubit.toggle();
    expect(cubit.state, isFalse);
    expect(HiveService.instance.userStorage.isBalanceHidden, isFalse);
    await cubit.close();
  });

  test('BalanceVisibilityCubit restores saved preference on initialization', () async {
    await HiveService.instance.userStorage.setBalanceHidden(true);

    final cubit = BalanceVisibilityCubit();
    expect(cubit.state, isTrue);
    await cubit.close();
  });
}
