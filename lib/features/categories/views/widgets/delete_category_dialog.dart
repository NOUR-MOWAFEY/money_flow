import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/delete_category_dialog_header.dart';

class DeleteCategoryDialog extends StatelessWidget {
  const DeleteCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bg,

      title: const DeleteCategoryDialogHeader(),

      content: const CustomText(
        'Are you sure you want to delete this category? This action is permanent and cannot be undone.',
        textAlign: .center,
      ),

      actions: [
        CustomButton(
          title: 'Cancel',
          width: 100,
          height: 42,
          color: AppColors.secondaryColor,
          textSize: 14,
          onTap: () => Navigator.pop(context),
        ),

        BlocConsumer<EditCategoryCubit, EditCategoryState>(
          listener: (BuildContext context, state) {
            if (state is EditCategoryFailure) {
              ShowToastification.failure(context, state.errorMessage);
            }
          },

          builder: (BuildContext context, state) => state is EditCategoryLoading
              ? const _LoadingButton()
              : const _DeleteButton(),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Delete',
      width: 120,
      height: 42,
      color: AppColors.error,
      textSize: 14,
      onTap: () async {
        await context.read<EditCategoryCubit>().deleteCategory();

        if (!context.mounted) return;

        Navigator.pop(context);
      },
    );
  }
}

class _LoadingButton extends StatelessWidget {
  const _LoadingButton();

  @override
  Widget build(BuildContext context) {
    return const CustomButton(
      title: 'Loading...',
      width: 120,
      height: 42,
      color: AppColors.grey,
      textSize: 14,
    );
  }
}
