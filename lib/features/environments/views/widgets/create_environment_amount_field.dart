import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class CreateEnvironmentAmountField extends StatelessWidget {
  const CreateEnvironmentAmountField({
    super.key,
    required this.controller,
    required this.currency,
  });

  final TextEditingController controller;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Initial Amount ($currency)',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormFiled(
          controller: controller,
          textInputAction: .done,
          hintText: '0.00',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          isNormalTextField: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          showPrefixIcon: false,
          centerText: false,
          showCursor: true,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter an initial amount';
            }
            final parsed = double.tryParse(val.trim());
            if (parsed == null || parsed < 0) {
              return 'Enter a valid positive number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
