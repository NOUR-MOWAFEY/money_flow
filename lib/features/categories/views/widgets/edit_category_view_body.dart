import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_color_button.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_icon_button.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_name_field.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_type_field.dart';

class EditCategoryViewBody extends StatelessWidget {
  const EditCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<EditCategoryCubit, EditCategoryState>(
        buildWhen: (previous, current) =>
            previous is EditCategoryLoading != current is EditCategoryLoading,
        listener: (context, state) {
          if (state is EditCategorySuccess) {
            ShowToastification.success(
              context,
              'Category updated successfully',
            );
            Navigator.pop(context);
          } else if (state is EditCategoryFailure) {
            ShowToastification.failure(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return state is EditCategoryLoading
              ? const CustomLoading()
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditCategoryNameField(),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        // icon
                        EditCategoryIconButton(),

                        SizedBox(width: 12),

                        // color
                        EditCategoryColorButton(),

                        SizedBox(width: 12),

                        // type
                        EditCategoryTypeField(),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
