import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';

class ColorPickerAlertDialogFooter extends StatelessWidget {
  const ColorPickerAlertDialogFooter({super.key, required this.currentColor});

  final Color? currentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: .end,
        children: [
          CustomButton(
            width: 90,
            color: AppColors.black1,
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
              context.read<NewCategoryCubit>().selectColor(
                currentColor ?? Colors.white,
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
