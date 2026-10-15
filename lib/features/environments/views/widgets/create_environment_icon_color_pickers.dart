import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_color_button.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_icon_button.dart';

class CreateEnvironmentIconColorPickers extends StatelessWidget {
  const CreateEnvironmentIconColorPickers({
    super.key,
    required this.selectedIcon,
    required this.selectedColor,
    required this.onPickIcon,
    required this.onPickColor,
  });

  final CategoryIcon selectedIcon;
  final Color selectedColor;
  final VoidCallback onPickIcon;
  final VoidCallback onPickColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NewCategoryIconButton(icon: selectedIcon.icon, onTap: onPickIcon),
        const SizedBox(width: 12),
        NewCategoryColorButton(color: selectedColor, onTap: onPickColor),
      ],
    );
  }
}
