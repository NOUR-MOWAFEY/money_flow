import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class TopUpButton extends StatelessWidget {
  const TopUpButton({
    super.key,
    required this.formKey,
    required this.amountController,
    required this.deductFromMain,
    required this.onTopUp,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final bool deductFromMain;
  final void Function(double amount, bool deductFromMain) onTopUp;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Add Funds',
      color: AppColors.primary,
      onTap: () {
        if (!formKey.currentState!.validate()) return;
        final amount = double.tryParse(amountController.text.trim()) ?? 0.0;
        onTopUp(amount, deductFromMain);
        Navigator.of(context).pop();
      },
    );
  }
}
