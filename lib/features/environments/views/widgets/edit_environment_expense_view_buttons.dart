import 'package:flutter/material.dart';
import 'package:money_flow/features/calculator/views/widgets/calculator_button.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/edit_environment_expense_button.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';

class EditEnvironmentExpenseViewButtons extends StatelessWidget {
  const EditEnvironmentExpenseViewButtons({
    super.key,
    required this.transactionDataModel,
    required this.environment,
    required this.expense,
  });

  final TransactionDataModel transactionDataModel;
  final EnvironmentModel environment;
  final EnvironmentExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: EditEnvironmentExpenseButton(
            transactionDataModel: transactionDataModel,
            environment: environment,
            expense: expense,
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
