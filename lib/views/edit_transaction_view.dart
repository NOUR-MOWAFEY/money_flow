import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/widgets/custom_back_button.dart';
import 'package:money_flow/widgets/edit_transaction_view_body.dart';

class EditTransactionView extends StatelessWidget {
  const EditTransactionView({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Edit Transaction'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditTransactionViewBody(transactionModel: transactionModel),
      ),
    );
  }
}
