import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/views/calculator_view.dart';
import 'package:money_flow/widgets/custom_button.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({super.key, required this.addTransactionModel});

  final TransactionDataModel addTransactionModel;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: AppColors.secondaryColor,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculatorView(
              amountController: addTransactionModel.amountController,
            ),
          ),
        );
      },
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.calculator,
          color: Color.fromARGB(222, 20, 20, 20),
          size: 22,
        ),
      ),
    );
  }
}
