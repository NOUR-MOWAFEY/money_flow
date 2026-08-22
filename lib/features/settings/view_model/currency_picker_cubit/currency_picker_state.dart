import 'package:money_flow/features/settings/data/models/currency_model.dart';

class CurrencyPickerState {
  const CurrencyPickerState({required this.currencies, this.selectedCurrency});

  final List<CurrencyModel> currencies;
  final CurrencyModel? selectedCurrency;
}
