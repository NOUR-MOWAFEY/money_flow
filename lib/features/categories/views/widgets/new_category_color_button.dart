import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/category_color_picker_dialog.dart';

class NewCategoryColorButton extends StatelessWidget {
  const NewCategoryColorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Color: '),

        const SizedBox(height: 8),

        GestureDetector(
          onTap: () {
            final cubit = context.read<NewCategoryCubit>();

            showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: DialogOpenAnimation(
                  child: const CategoryColorPickerDialog(),
                ),
              ),
            );
          },

          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondaryColor,
            ),

            child: BlocBuilder<NewCategoryCubit, NewCategoryState>(
              builder: (context, state) {
                return Center(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      shape: .circle,
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
