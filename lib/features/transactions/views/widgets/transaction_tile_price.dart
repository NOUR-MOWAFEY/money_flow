import 'package:flutter/material.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class TransactionTilePrice extends StatelessWidget {
  const TransactionTilePrice({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    final textColor = _getTextColor();
    final sign = transactionModel.isExpense ? '-' : '+';

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            sign,
            color: textColor,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(width: 2),
          CustomText(
            transactionModel.amount.toString(),
            color: textColor,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTextColor() {
    return transactionModel.isExpense ? Colors.red : Colors.green;
  }
}
