import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/category_resolver.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

CategoryModel getCategory(
  String title,
  bool isExpenses,
  HiveService hiveService,
) {
  final allCategories = [
    ...AppCategories.expenseCategories,
    ...AppCategories.incomeCategories,
    ...hiveService.getCategories(),
  ];

  return CategoryResolver.findCategory(
    title: title,
    isExpense: isExpenses,
    allCategories: allCategories,
  );
}
