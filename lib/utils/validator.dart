import 'package:flutter/material.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/utils/show_toastification.dart';

class Validator {
  static void checkAddTransactionFields(
    BuildContext context,
    TransactionDataModel addTransactionModel, {
    void Function()? onValid,
  }) {
    final amount = addTransactionModel.amountController.text;

    if (amount.isEmpty || _isInvalidAmount(amount)) {
      ShowToastification.failure(context, 'Please enter an amount');
    } else if (addTransactionModel.category.value == null) {
      ShowToastification.failure(context, 'Please choose a category');
    } else {
      onValid?.call();
    }
  }

  static bool _isInvalidAmount(String value) {
    final parsed = double.tryParse(value);
    return parsed == null || parsed <= 0;
  }
}
