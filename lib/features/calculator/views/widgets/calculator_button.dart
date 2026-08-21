import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/calculator/views/calculator_view.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({super.key, required this.transactionDataModel});

  final TransactionDataModel transactionDataModel;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: AppColors.black1,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculatorView(
              amountController: transactionDataModel.amountController,
            ),
          ),
        );
      },
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.calculator,
          color: AppColors.icon,
          size: 22,
        ),
      ),
    );
  }
}
