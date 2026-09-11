import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_currencies.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/settings/data/models/currency_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_state.dart';

class CurrencyPickerCubit extends Cubit<CurrencyPickerState> {
  CurrencyPickerCubit()
    : super(
        CurrencyPickerState(
          currencies: AppCurrencies.currencies,
          selectedCurrency: _getInitialCurrency(),
        ),
      );

  static CurrencyModel? _getInitialCurrency() {
    final currentCode = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';
    try {
      return AppCurrencies.currencies.firstWhere(
        (c) => c.code.toUpperCase() == currentCode.toUpperCase(),
      );
    } catch (_) {
      return AppCurrencies.currencies.first;
    }
  }

  void searchCurrencies(String query) {
    final search = query.trim().toLowerCase();

    if (search.isEmpty) {
      emit(
        CurrencyPickerState(
          currencies: AppCurrencies.currencies,
          selectedCurrency: state.selectedCurrency,
        ),
      );
      return;
    }

    final filteredCurrencies = AppCurrencies.currencies.where((currency) {
      return currency.name.toLowerCase().contains(search) ||
          currency.code.toLowerCase().contains(search);
    }).toList();

    emit(
      CurrencyPickerState(
        currencies: filteredCurrencies,
        selectedCurrency: state.selectedCurrency,
      ),
    );
  }

  Future<void> selectCurrency(CurrencyModel currency) async {
    emit(
      CurrencyPickerState(
        currencies: state.currencies,
        selectedCurrency: currency,
      ),
    );

    final user = HiveService.getUserModel();
    if (user != null) {
      await HiveService.updateUserModel(defaultCurrency: currency.code);
    } else {
      await HiveService.saveUserModel(
        UserModel(
          name: 'User',
          defaultCurrency: currency.code,
          isFirstTime: false,
        ),
      );
    }
  }
}
