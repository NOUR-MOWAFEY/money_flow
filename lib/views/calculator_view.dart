import 'package:flutter/material.dart';
import 'package:money_flow/widgets/calculator_view_body.dart';
import 'package:money_flow/widgets/custom_back_button.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Calculator'),
      ),
      body: CalculatorViewBody(amountController: amountController),
    );
  }
}
