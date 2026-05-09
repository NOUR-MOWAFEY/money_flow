import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transactionModel});

  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        child: Icon(
          IconData(transactionModel.icon, fontFamily: 'MaterialIcons'),
        ),
      ),

      title: Text(
        transactionModel.title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      subtitle: Text(transactionModel.date, style: TextStyle(fontSize: 12)),

      trailing: Text(
        transactionModel.amount.toString(),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
