import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/edit_transaction_view_body.dart';

class EditTransactionView extends StatelessWidget {
  const EditTransactionView({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: const CustomAppBar(title: 'Edit Transaction'),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditTransactionViewBody(transactionModel: transactionModel),
      ),
    );
  }
}
