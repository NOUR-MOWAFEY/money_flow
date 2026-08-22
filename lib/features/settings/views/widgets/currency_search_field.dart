import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_cubit.dart';

class CurrencySearchField extends StatelessWidget {
  const CurrencySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,

      onChanged: context.read<CurrencyPickerCubit>().searchCurrencies,

      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: 'Search for currency',

        prefixIcon: const Icon(Icons.search, size: 22),

        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}
