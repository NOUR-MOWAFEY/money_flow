import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/widgets/calculator_button.dart';
import 'package:money_flow/widgets/edit_transaction_button.dart';

class EditTransactionViewButtons extends StatelessWidget {
  const EditTransactionViewButtons({
    super.key,
    required this.transactionModel,
    required this.transactionDataModel,
  });

  final TransactionModel transactionModel;
  final TransactionDataModel transactionDataModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: EditTransactionButton(
            transactionModel: transactionModel,
            transactionDataModel: transactionDataModel,
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
