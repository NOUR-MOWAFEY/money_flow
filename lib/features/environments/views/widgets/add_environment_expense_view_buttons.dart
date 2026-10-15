import 'package:flutter/material.dart';
import 'package:money_flow/features/calculator/views/widgets/calculator_button.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/add_environment_expense_button.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';

class AddEnvironmentExpenseViewButtons extends StatelessWidget {
  const AddEnvironmentExpenseViewButtons({
    super.key,
    required this.transactionDataModel,
    required this.environment,
  });

  final TransactionDataModel transactionDataModel;
  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: AddEnvironmentExpenseButton(
            transactionDataModel: transactionDataModel,
            environment: environment,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CalculatorButton(transactionDataModel: transactionDataModel),
        ),
      ],
    );
  }
}
