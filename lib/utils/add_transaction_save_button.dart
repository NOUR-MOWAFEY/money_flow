import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/widgets/home_view_header.dart';
import 'package:toastification/toastification.dart';

Future<void> onSave(
  TextEditingController amountController,
  TextEditingController categoryController,
  TextEditingController dateController,
  ValueNotifier<int> transactionType,
  BuildContext context,
) async {
  if (num.tryParse(amountController.text) == null) {
    toastification.show(
      icon: Icon(Icons.warning_rounded, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.red,
      borderSide: BorderSide(color: Colors.red),
      context: context,
      title: Text(
        'Please enter a valid amount',
        style: TextStyle(color: AppColors.white),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
    return;
  }

  if (amountController.text.isEmpty ||
      categoryController.text.isEmpty ||
      dateController.text.isEmpty) {
    toastification.show(
      icon: Icon(Icons.warning_rounded, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.red,
      borderSide: BorderSide(color: Colors.red),
      context: context,
      title: Text(
        'Please fill all fields with valid data',
        style: TextStyle(color: AppColors.white),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
    return;
  }

  final amount = transactionType.value == 1
      ? double.parse(amountController.text)
      : -double.parse(amountController.text);

  final transaction = TransactionModel(
    title: categoryController.text,
    amount: amount,
    date: DateFormat.yMMMd().parse(dateController.text),
    isExpense: transactionType.value == 0,
  );

  await HiveService().addTransaction(transaction);
  BalanceController.updateBalance();

  if (!context.mounted) return;

  Navigator.pop(context);

  toastification.show(
    icon: Icon(Icons.check_circle_outline, color: AppColors.white),
    foregroundColor: AppColors.white,
    backgroundColor: Colors.green,
    borderSide: BorderSide(color: Colors.green),
    context: context,
    title: Text(
      'Transaction added successfully',
      style: TextStyle(color: AppColors.white),
    ),
    autoCloseDuration: const Duration(seconds: 3),
  );
}
