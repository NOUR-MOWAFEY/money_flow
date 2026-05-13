import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';

class TransactionDataModel {
  final TextEditingController amountController;
  final ValueNotifier<DateTime> date;
  final ValueNotifier<TransactionType> transactionType;
  final ValueNotifier<CategoryModel?> category;

  TransactionDataModel({
    required this.amountController,
    required this.date,
    required this.transactionType,
    required this.category,
  });
}
