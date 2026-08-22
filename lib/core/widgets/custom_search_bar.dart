import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.hint, this.onChanged});
  final String hint;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,

      onChanged: onChanged,

      textAlignVertical: TextAlignVertical.center,

      decoration: InputDecoration(
        hintText: hint,

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
