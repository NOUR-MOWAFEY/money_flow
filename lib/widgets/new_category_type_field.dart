import 'package:flutter/material.dart';
import 'package:money_flow/widgets/custom_text.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class NewCategoryTypeField extends StatelessWidget {
  const NewCategoryTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CustomText('Category Type: '),
          SizedBox(height: 8),
          CustomTextFormFiled(
            title: 'Income',
            isEnabled: false,
            centerText: false,
            isNormalTextField: true,
            showCursor: true,
            showPrefixIcon: false,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          ),
        ],
      ),
    );
  }
}
