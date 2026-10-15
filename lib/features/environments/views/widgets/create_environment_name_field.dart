import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class CreateEnvironmentNameField extends StatelessWidget {
  const CreateEnvironmentNameField({
    super.key,
    required this.controller,
  });

  static const int maxLength = 20;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Environment Name',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomText(
              'Max $maxLength chars',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white38,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextFormFiled(
          controller: controller,
          textInputAction: .done,
          hintText: 'e.g. Home Shopping, Vacation',
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          isNormalTextField: true,
          showPrefixIcon: false,
          centerText: false,
          showCursor: true,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          formatter: [
            LengthLimitingTextInputFormatter(maxLength),
          ],
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter a name';
            }
            if (val.trim().length > maxLength) {
              return 'Name cannot exceed $maxLength characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
