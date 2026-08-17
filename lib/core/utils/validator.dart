import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';

class Validator {
  static void checkAddTransactionFields(
    BuildContext context,
    TransactionDataModel addTransactionModel, {
    void Function()? onValid,
  }) {
    final amount = addTransactionModel.amountController.text;
    final selectedCategory = addTransactionModel.category.value;
    final transactionType = addTransactionModel.transactionType.value;

    if (amount.isEmpty || _isInvalidAmount(amount)) {
      ShowToastification.failure(context, 'Please enter an amount');
    } else if (selectedCategory == null) {
      ShowToastification.failure(context, 'Please choose a category');
    } else if (!_isCategoryAvailable(selectedCategory, transactionType)) {
      addTransactionModel.category.value = null;
      ShowToastification.failure(
        context,
        'Selected category is no longer available. Please select another category',
      );
    } else {
      onValid?.call();
    }
  }

  static bool _isCategoryAvailable(CategoryModel category, CategoryType type) {
    final defaultCategories = type == CategoryType.expenses
        ? AppCategories.expenseCategories
        : AppCategories.incomeCategories;

    final isDefault = defaultCategories.any(
      (c) => c.title.toLowerCase() == category.title.toLowerCase(),
    );

    if (isDefault) return true;

    if (category.isInBox && category.categoryType == type) {
      return true;
    }

    final userCategories = HiveService().getCategoriesByType(type);
    return userCategories.any(
      (c) => c.title.toLowerCase() == category.title.toLowerCase(),
    );
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
