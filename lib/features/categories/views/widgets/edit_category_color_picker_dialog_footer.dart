import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class EditCategoryColorPickerDialogFooter extends StatelessWidget {
  const EditCategoryColorPickerDialogFooter({
    super.key,
    required this.currentColor,
  });

  final Color? currentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            width: 90,
            color: AppColors.secondaryColor,
            title: 'Cancel',
            textSize: 14,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
          CustomButton(
            width: 120,
            textSize: 14,
            title: 'Use',
            onTap: () {
              Navigator.pop(context, currentColor ?? Colors.white);
            },
          ),
        ],
      ),
    );
  }
}
