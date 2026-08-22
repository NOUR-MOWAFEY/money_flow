import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/calculator/views/widgets/calculator_view_body.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Calculator'),
      body: CalculatorViewBody(amountController: amountController),
    );
  }
}
