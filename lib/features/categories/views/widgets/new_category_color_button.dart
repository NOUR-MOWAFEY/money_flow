import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/category_color_picker_dialog.dart';

class NewCategoryColorButton extends StatelessWidget {
  const NewCategoryColorButton({
    super.key,
    this.color,
    this.onTap,
  });

  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Color: '),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap ??
              () {
                FocusManager.instance.primaryFocus?.unfocus();

                final cubit = context.read<NewCategoryCubit>();

                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: const DialogOpenAnimation(
                      child: CategoryColorPickerDialog(),
                    ),
                  ),
                );
              },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.black1,
            ),
            child: Center(
              child: _buildColorCircle(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorCircle(BuildContext context) {
    if (color != null) {
      return Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
    }

    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        return Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state.selectedColor ?? Colors.white,
          ),
        );
      },
    );
  }
}
