import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';

class NewCategoryNameField extends StatelessWidget {
  const NewCategoryNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Category Name: '),
        const SizedBox(height: 8),
        CustomTextFormFiled(
          controller: context.read<NewCategoryCubit>().nameController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          isNormalTextField: true,
          showPrefixIcon: false,
          centerText: false,
          showCursor: true,

          validator: (text) {
            final trimmedText = text?.trim() ?? '';

            if (trimmedText.isEmpty) {
              return 'Required Field';
            }

            if (trimmedText.length < 3) {
              return 'Name must be at least 3 letters';
            }

            return null;
          },
        ),
      ],
    );
  }
}
