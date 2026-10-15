import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class CreateEnvironmentDescField extends StatelessWidget {
  const CreateEnvironmentDescField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Description (Optional)',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormFiled(
          controller: controller,
          textInputAction: .done,
          hintText: 'e.g. Groceries and furniture budget',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          isNormalTextField: true,
          showPrefixIcon: false,
          centerText: false,
          showCursor: true,
        ),
      ],
    );
  }
}
