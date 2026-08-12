import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/icon_picker_cubit.dart';

class IconSearchField extends StatelessWidget {
  const IconSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      onChanged: context.read<IconPickerCubit>().searchIcons,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: 'Search for icons',

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
