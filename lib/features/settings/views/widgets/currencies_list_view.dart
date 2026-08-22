import 'package:flutter/material.dart';
import 'package:money_flow/features/settings/data/models/currency_model.dart';
import 'package:money_flow/features/settings/views/widgets/currency_list_view_item.dart';

class CurrenciesListView extends StatelessWidget {
  const CurrenciesListView({
    super.key,
    required this.currencies,
    this.selectedCurrency,
  });
  final List<CurrencyModel> currencies;
  final CurrencyModel? selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencies.length,

      itemBuilder: (context, index) => CurrencyListViewItem(
        currency: currencies[index],
        isSelected: selectedCurrency == currencies[index],
        isLastItem: index == currencies.length - 1,
      ),
    );
  }
}
