import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/delete_category_dialog.dart';

class DeleteCategoryButton extends StatelessWidget {
  const DeleteCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Delete',
      color: AppColors.error,
      onTap: () {
        final editCategoryCubit = context.read<EditCategoryCubit>();

        showDialog(
          context: context,
          builder: (context) => BlocProvider.value(
            value: editCategoryCubit,
            child: const DialogOpenAnimation(child: DeleteCategoryDialog()),
          ),
        );
      },
    );
  }
}
