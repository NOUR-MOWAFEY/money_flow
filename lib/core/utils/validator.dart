import 'package:flutter/material.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/core/utils/show_toastification.dart';

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

  static String? categoryNameValidator(String? text) {
    final trimmedText = text?.trim() ?? '';

    if (trimmedText.isEmpty) {
      return 'Required Field';
    }

    final lines = trimmedText.split('\n');

    if (lines.length > 2) {
      return 'Enter at most 2 lines';
    }

    if (lines.any((line) => line.trim().length > 10)) {
      return 'Each line must be at most 10 letters';
    }

    return null;
  }

  static bool _isInvalidAmount(String value) {
    final parsed = double.tryParse(value);
    return parsed == null || parsed <= 0;
  }
}
