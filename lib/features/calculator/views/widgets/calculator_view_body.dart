import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class CalculatorViewBody extends StatelessWidget {
  const CalculatorViewBody({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 250),

        Expanded(
          child: SimpleCalculator(
            onChanged: (key, value, expression) {
              amountController.text =
                  value?.toStringAsFixed(2).toString() ?? '0';
            },

            maximumDigits: 8,
            hideSurroundingBorder: true,

            theme: const CalculatorThemeData(
              borderColor: AppColors.greyTrasparent,
              operatorColor: AppColors.primary,
              equalColor: AppColors.primary,
              borderWidth: 0,
            ),
          ),
        ),

        const Divider(height: 0, thickness: 0.5),

        const SizedBox(height: 25),

        // done button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            title: 'Done',
            onTap: () => Navigator.pop(context),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
