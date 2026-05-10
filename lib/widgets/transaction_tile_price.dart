import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_model.dart';

class TransactionTilePrice extends StatelessWidget {
  const TransactionTilePrice({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        Text(
          transactionModel.isExpense ? '-' : '+',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _getTextColor(),
          ),
        ),
        Text(
          transactionModel.amount.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _getTextColor(),
          ),
        ),
      ],
    );
  }

  MaterialColor _getTextColor() {
    return transactionModel.isExpense ? Colors.red : Colors.green;
  }
}
