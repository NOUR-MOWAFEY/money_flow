import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.filteredList});

  final void Function(List<CategoryIcon> filteredIcons) filteredList;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          filteredList(AppIcons.searchIcons(value));
        } else {
          filteredList(AppIcons.icons);
        }
      },
      decoration: const InputDecoration(
        hintText: 'Search for icons',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
