import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class NewCategoryNameField extends StatelessWidget {
  const NewCategoryNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText('Category Name: '),
        SizedBox(height: 8),
        CustomTextFormFiled(
          centerText: false,
          isNormalTextField: true,
          showCursor: true,
          showPrefixIcon: false,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ],
    );
  }
}
