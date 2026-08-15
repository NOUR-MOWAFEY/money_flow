import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/text_input_formatter.dart';
import 'package:money_flow/core/utils/validator.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';

class EditCategoryNameField extends StatelessWidget {
  const EditCategoryNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Category Name: '),

        const SizedBox(height: 8),

        CustomTextFormFiled(
          controller: context.read<EditCategoryCubit>().nameController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          validator: Validator.categoryNameValidator,
          formatter: [InputFormatters.categoryNameInputFormatter()],
          isNormalTextField: true,
          showPrefixIcon: false,
          centerText: false,
          showCursor: true,
        ),
      ],
    );
  }
}
