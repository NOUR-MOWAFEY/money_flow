import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions/views/widgets/amount_field.dart';

class RecurringAmountField extends StatelessWidget {
  const RecurringAmountField({super.key, required this.amountController});

  final TextEditingController? amountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Amount: ',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 12),

        AmountField(amountController: amountController),
      ],
    );
  }
}
