import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_search_bar.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_cubit.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_state.dart';
import 'package:money_flow/features/settings/views/widgets/currencies_list_view.dart';

class CurrencyViewBody extends StatelessWidget {
  const CurrencyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),

      child: Column(
        crossAxisAlignment: .start,

        children: [
          const _CurrencySearchBar(),

          const SizedBox(height: 4),

          Expanded(
            child: BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
              builder: (context, state) => CurrenciesListView(
                currencies: state.currencies,
                selectedCurrency: state.selectedCurrency,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencySearchBar extends StatelessWidget {
  const _CurrencySearchBar();

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      hint: 'Search for currency',
      onChanged: context.read<CurrencyPickerCubit>().searchCurrencies,
    );
  }
}
