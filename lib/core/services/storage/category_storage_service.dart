import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/storage/budget_storage_service.dart';
import 'package:money_flow/core/services/storage/recurring_storage_service.dart';
import 'package:money_flow/core/services/storage/transaction_storage_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

/// Storage service dedicated to managing categories and cascading updates.
class CategoryStorageService {
  final TransactionStorageService transactionStorage;
  final RecurringStorageService recurringStorage;
  final BudgetStorageService budgetStorage;

  const CategoryStorageService({
    this.transactionStorage = const TransactionStorageService(),
    this.recurringStorage = const RecurringStorageService(),
    this.budgetStorage = const BudgetStorageService(),
  });

  static const String boxName = 'categories';

  Box<CategoryModel> get _box => Hive.box<CategoryModel>(boxName);

  /// Adds a custom category.
  Future<void> addCategory(CategoryModel category) async {
    await _box.add(category);
  }

  /// Adds multiple custom categories.
  Future<void> addCategories(List<CategoryModel> categories) async {
    await _box.addAll(categories);
  }

  /// Deletes a category and reassigns associated transactions, recurring rules, and budgets.
  Future<void> deleteCategory(CategoryModel category) async {
    if (!category.isInBox) return;

    final categoryTitle = category.title;
    final isExpense = category.categoryType == CategoryType.expenses;

    await category.delete();

    // Reassign transactions
    await transactionStorage.reassignDeletedCategory(
      categoryTitle,
      isExpense: isExpense,
      fallbackTitle: AppCategories.deletedCategory.title,
    );

    // Reassign recurring transactions
    await recurringStorage.reassignDeletedCategory(
      categoryTitle,
      isExpense: isExpense,
      fallbackTitle: AppCategories.deletedCategory.title,
    );

    // Delete budgets for deleted category
    await budgetStorage.deleteBudgetsForCategory(categoryTitle);
  }

  /// Returns all custom categories.
  List<CategoryModel> getCategories() {
    return _box.values.toList();
  }

  /// Real-time stream of category box changes.
  Stream<BoxEvent> watchCategories() => _box.watch();

  /// Returns custom categories filtered by [CategoryType].
  List<CategoryModel> getCategoriesByType(CategoryType type) {
    return _box.values
        .where((category) => category.categoryType == type)
        .toList();
  }

  /// Returns custom expense categories.
  List<CategoryModel> getExpenseCategories() {
    return getCategoriesByType(CategoryType.expenses);
  }

  /// Updates a category and synchronizes existing transactions and budgets if renamed.
  Future<void> updateCategory(
    CategoryModel category, {
    String? title,
    IconData? icon,
    Color? color,
    CategoryType? categoryType,
  }) async {
    if (!category.isInBox) return;

    final oldTitle = category.title;
    final oldIsExpense = category.categoryType == CategoryType.expenses;

    if (title != null) category.title = title;
    if (icon != null) category.icon = icon;
    if (color != null) category.color = color;
    if (categoryType != null) category.categoryType = categoryType;

    await category.save();

    final newTitle = category.title;
    final newIsExpense = category.categoryType == CategoryType.expenses;

    // If title or type changed, synchronize existing transactions using this category
    if (oldTitle != newTitle || oldIsExpense != newIsExpense) {
      await transactionStorage.reassignCategory(
        oldTitle,
        newTitle,
        isExpense: oldIsExpense,
        newIsExpense: newIsExpense,
      );

      await recurringStorage.reassignCategory(
        oldTitle,
        newTitle,
        isExpense: oldIsExpense,
        newIsExpense: newIsExpense,
      );

      if (oldIsExpense && oldTitle != newTitle) {
        await budgetStorage.renameBudgetCategory(oldTitle, newTitle);
      }
    }
  }

  /// Clears all categories from the box.
  Future<void> clearCategories() async {
    await _box.clear();
  }
}
