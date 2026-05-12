import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/models/category_model.dart';

CategoryModel getCategory(String title, bool isExpenses) {
  final list = isExpenses
      ? AppCategories.expenseCategories
      : AppCategories.incomeCategories;
  final category = list.firstWhere(
    (element) => element.title == title,
    orElse: () => AppCategories.defaultCategory, // or some fallback
  );
  return category;
}
