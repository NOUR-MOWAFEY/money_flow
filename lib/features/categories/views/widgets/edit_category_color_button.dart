import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_color_picker_dialog.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_color_button.dart';

class EditCategoryColorButton extends StatelessWidget {
  const EditCategoryColorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditCategoryCubit>();

    return BlocBuilder<EditCategoryCubit, EditCategoryState>(
      builder: (context, state) {
        return NewCategoryColorButton(
          color: state.selectedColor,
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();

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
        );
      },
    );
  }
}
