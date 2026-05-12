import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/widgets/amount_field.dart';
import 'package:money_flow/widgets/category_field.dart';
import 'package:money_flow/widgets/date_field.dart';

class AddTransactionFields extends StatelessWidget {
  const AddTransactionFields({super.key, required this.addTransactionModel});

  final TransactionDataModel addTransactionModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // amount field
        AmountField(amountController: addTransactionModel.amountController),

        const SizedBox(height: 32),

        // Category field
        CategoryField(
          transactionType: addTransactionModel.transactionType,
          category: addTransactionModel.category,
        ),

        const SizedBox(height: 16),

        // Date Field
        DateField(dateController: addTransactionModel.dateController),
      ],
    );
  }
}
