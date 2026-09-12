import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class OnboardingNameField extends StatelessWidget {
  const OnboardingNameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Your Name',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormFiled(
          controller: controller,
          hintText: 'e.g. Nour Mowafey',
          icon: Icons.person_outline_rounded,
          isNormalTextField: true,
          showPrefixIcon: true,
          centerText: false,
          showCursor: true,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
