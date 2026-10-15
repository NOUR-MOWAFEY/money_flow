import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';

class TopUpAmountField extends StatelessWidget {
  const TopUpAmountField({
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
          'Top-Up Amount ($currency)',
          style: const TextStyle(fontSize: 13, color: Colors.white70),
        ),
        const SizedBox(height: 6),
        CustomTextFormFiled(
          controller: controller,
          hintText: '0.00',
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          isNormalTextField: true,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          showPrefixIcon: false,
          centerText: false,
          showCursor: true,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter an amount';
            }
            final parsed = double.tryParse(val.trim());
            if (parsed == null || parsed <= 0) {
              return 'Enter a valid amount greater than 0';
            }
            return null;
          },
        ),
      ],
    );
  }
}
