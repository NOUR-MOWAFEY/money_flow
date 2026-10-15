import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/edit_transaction_view_body.dart';

class EditTransactionView extends StatelessWidget {
  const EditTransactionView({
    super.key,
    required this.transactionModel,
    this.showTypeToggle = true,
    this.title = 'Edit Transaction',
    this.onSave,
  });

  final TransactionModel transactionModel;
  final bool showTypeToggle;
  final String title;
  final Future<void> Function(TransactionDataModel dataModel)? onSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: title),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditTransactionViewBody(
          transactionModel: transactionModel,
          showTypeToggle: showTypeToggle,
          onSave: onSave,
        ),
      ),
    );
  }
}
