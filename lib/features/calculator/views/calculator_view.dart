import 'package:flutter/material.dart';
import 'package:money_flow/features/calculator/views/widgets/calculator_view_body.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const CustomText('Calculator'),
      ),
      body: CalculatorViewBody(amountController: amountController),
    );
  }
}
