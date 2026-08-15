import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

CategoryModel getCategory(
  String title,
  bool isExpenses,
  HiveService hiveService,
) {
  final predefinedList = isExpenses
      ? AppCategories.expenseCategories
      : AppCategories.incomeCategories;

  // 1. Check predefined categories first
  for (final category in predefinedList) {
    if (category.title == title) return category;
  }

  // 2. Check user-created (stored) categories
  final storedCategories = hiveService
      .getCategories(); // <-- adjust to real API
  for (final category in storedCategories) {
    if (category.title == title &&
        category.categoryType ==
            (isExpenses ? CategoryType.expenses : CategoryType.income)) {
      return category;
    }
  }

  // 3. Fallback
  return AppCategories.defaultCategory;
}
