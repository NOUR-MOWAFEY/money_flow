import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/widgets/add_transaction_button.dart';
import 'package:money_flow/widgets/calculator_button.dart';

class AddTransactionViewButtons extends StatelessWidget {
  const AddTransactionViewButtons({
    super.key,
    required this.addTransactionModel,
  });

  final TransactionDataModel addTransactionModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: AddTransactionButton(
            transactionDataModel: addTransactionModel,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          flex: 2,
          child: CalculatorButton(transactionDataModel: addTransactionModel),
        ),
      ],
    );
  }
}
