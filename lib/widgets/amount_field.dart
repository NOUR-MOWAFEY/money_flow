import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/utils/text_input_formatter.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: CustomTextFormFiled(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: amountController,
        showPrefixIcon: false,
        hintText: 'EGP 0',
        border: 80,
        padding: const EdgeInsets.symmetric(vertical: 24),
        borderColor: AppColors.grey,
        formatter: [MaxDigitsFormatter()],
      ),
    );
  }
}
