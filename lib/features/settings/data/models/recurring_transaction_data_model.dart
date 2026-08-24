import 'package:flutter/material.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';

class RecurringTransactionDataModel {
  RecurringTransactionDataModel({
    required this.amountController,
    required this.type,
    required this.category,
    required this.frequency,
    required this.startDate,
    required this.endDate,
  });

  factory RecurringTransactionDataModel.initial() {
    return RecurringTransactionDataModel(
      amountController: TextEditingController(),
      type: ValueNotifier<CategoryType>(CategoryType.expenses),
      category: ValueNotifier<CategoryModel?>(null),
      frequency: ValueNotifier<RecurrenceFrequency>(
        RecurrenceFrequency.monthly,
      ),
      startDate: ValueNotifier<DateTime>(DateTime.now()),
      endDate: ValueNotifier<DateTime?>(null),
    );
  }

  factory RecurringTransactionDataModel.fromModel(
    RecurringTransactionModel model, [
    HiveService? hiveService,
  ]) {
    final catTitle = model.categoryTitle ?? model.title;
    final cat = getCategory(
      catTitle,
      model.type == CategoryType.expenses,
      hiveService ?? HiveService.instance,
    );

    return RecurringTransactionDataModel(
      amountController: TextEditingController(
        text: model.amount == 0 ? '' : model.amount.toString(),
      ),
      type: ValueNotifier<CategoryType>(model.type),
      category: ValueNotifier<CategoryModel?>(cat),
      frequency: ValueNotifier<RecurrenceFrequency>(model.frequency),
      startDate: ValueNotifier<DateTime>(model.startDate),
      endDate: ValueNotifier<DateTime?>(model.endDate),
    );
  }

  final TextEditingController amountController;
  final ValueNotifier<CategoryType> type;
  final ValueNotifier<CategoryModel?> category;
  final ValueNotifier<RecurrenceFrequency> frequency;
  final ValueNotifier<DateTime> startDate;
  final ValueNotifier<DateTime?> endDate;

  void dispose() {
    amountController.dispose();
    type.dispose();
    category.dispose();
    frequency.dispose();
    startDate.dispose();
    endDate.dispose();
  }
}
