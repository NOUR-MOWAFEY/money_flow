import 'package:flutter/material.dart';
import 'package:money_flow/features/calculator/views/widgets/calculator_button.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/edit_transaction_button.dart';

class EditTransactionViewButtons extends StatelessWidget {
  const EditTransactionViewButtons({
    super.key,
    this.transactionModel,
    required this.transactionDataModel,
    this.onSave,
  });

  final TransactionModel? transactionModel;
  final TransactionDataModel transactionDataModel;
  final Future<void> Function(TransactionDataModel dataModel)? onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: EditTransactionButton(
            transactionModel: transactionModel,
            transactionDataModel: transactionDataModel,
            onSave: onSave,
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
