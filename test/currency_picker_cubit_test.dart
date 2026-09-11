import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/constants/app_currencies.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_cubit.dart';

void main() {
  late Directory tempDir;
  late CurrencyPickerCubit cubit;

  setUpAll(() {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('currency_test_');
    Hive.init(tempDir.path);
    await Hive.openBox('user');

    cubit = CurrencyPickerCubit();
  });

  tearDown(() async {
    await cubit.close();
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('Initial state loads currencies and sets selected currency from user model', () {
    expect(cubit.state.currencies.length, AppCurrencies.currencies.length);
    expect(cubit.state.selectedCurrency?.code, 'EGP');
  });

  test('searchCurrencies filters currencies by name and code', () {
    cubit.searchCurrencies('dollar');
    expect(
      cubit.state.currencies.any((c) => c.name.toLowerCase().contains('dollar')),
      true,
    );

    cubit.searchCurrencies('EUR');
    expect(cubit.state.currencies.length, 1);
    expect(cubit.state.currencies.first.code, 'EUR');

    cubit.searchCurrencies('');
    expect(cubit.state.currencies.length, AppCurrencies.currencies.length);
  });

  test('selectCurrency updates state and persists to Hive', () async {
    final usd = AppCurrencies.currencies.firstWhere((c) => c.code == 'USD');
    await cubit.selectCurrency(usd);

    expect(cubit.state.selectedCurrency?.code, 'USD');
    final savedUser = HiveService.getUserModel();
    expect(savedUser?.defaultCurrency, 'USD');
  });
}
