import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class TransactionDataModel {
  final TextEditingController amountController;
  final ValueNotifier<DateTime> date;
  final ValueNotifier<CategoryType> transactionType;
  final ValueNotifier<CategoryModel?> category;

  TransactionDataModel({
    required this.amountController,
    required this.date,
    required this.transactionType,
    required this.category,
  });
}
