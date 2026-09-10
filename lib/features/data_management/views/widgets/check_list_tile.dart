import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/extensions/color_extension.dart';

class ChecklistTile extends StatelessWidget {
  const ChecklistTile({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
    this.tristate = false,
    this.trailing,
    this.titleStyle,
  });

  final bool? value;
  final String title;
  final ValueChanged<bool?> onChanged;
  final bool tristate;
  final Widget? trailing;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      activeColor: AppColors.primary.categoryContainerColor,
      checkColor: AppColors.primary.categoryIconColor,
      value: value,
      tristate: tristate,
      onChanged: onChanged,
      title: Text(title, style: titleStyle),
      secondary: trailing,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
