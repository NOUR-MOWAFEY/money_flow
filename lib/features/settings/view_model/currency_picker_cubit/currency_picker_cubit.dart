import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_currencies.dart';
import 'package:money_flow/features/settings/data/models/currency_model.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_state.dart';

class CurrencyPickerCubit extends Cubit<CurrencyPickerState> {
  CurrencyPickerCubit()
    : super(const CurrencyPickerState(currencies: AppCurrencies.currencies));

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

  void selectCurrency(CurrencyModel currency) {
    if (state.selectedCurrency == currency) return;

    emit(
      CurrencyPickerState(
        currencies: state.currencies,
        selectedCurrency: currency,
      ),
    );
  }
}
