import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_color_picker_dialog.dart';

class EditCategoryColorButton extends StatelessWidget {
  const EditCategoryColorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Color: '),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();

            final editCubit = context.read<EditCategoryCubit>();

            final selectedColor = await showDialog<Color>(
              context: context,
              builder: (context) => DialogOpenAnimation(
                child: EditCategoryColorPickerDialog(
                  initialColor: editCubit.state.selectedColor ?? Colors.white,
                ),
              ),
            );

            if (selectedColor != null) {
              editCubit.selectColor(selectedColor);
            }
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondaryColor,
            ),
            child: BlocBuilder<EditCategoryCubit, EditCategoryState>(
              builder: (context, state) {
                return Center(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.selectedColor ?? Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
