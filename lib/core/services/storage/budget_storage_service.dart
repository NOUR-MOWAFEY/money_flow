import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';

/// Storage service dedicated to managing budgets.
class BudgetStorageService {
  const BudgetStorageService();

  static const String boxName = 'budgets';

  Box<BudgetModel> get _box => Hive.box<BudgetModel>(boxName);

  /// Adds a single budget.
  Future<void> addBudget(BudgetModel budget) async {
    await _box.add(budget);
  }

  /// Adds multiple budgets.
  Future<void> addBudgets(List<BudgetModel> budgets) async {
    await _box.addAll(budgets);
  }

  /// Clears all budgets.
  Future<void> clearBudgets() async {
    await _box.clear();
  }

  /// Deletes a budget.
  Future<void> deleteBudget(BudgetModel budget) async {
    await budget.delete();
  }

  /// Retrieves budgets, optionally filtered by [BudgetPeriod].
  List<BudgetModel> getBudgets([BudgetPeriod? period]) {
    if (period == null) {
      return _box.values.toList();
    }
    return _box.values.where((budget) => budget.period == period).toList();
  }

  /// Real-time stream of budget box changes.
  Stream<BoxEvent> watchBudgets() => _box.watch();

  /// Updates a budget's fields.
  Future<void> updateBudget(
    BudgetModel budget, {
    String? categoryTitle,
    double? limitAmount,
    BudgetPeriod? period,
  }) async {
    if (categoryTitle != null) budget.categoryTitle = categoryTitle;
    if (limitAmount != null) budget.limitAmount = limitAmount;
    if (period != null) budget.period = period;

    await budget.save();
  }

  /// Checks if a budget exists for the given category title.
  bool hasBudgetForCategory(String categoryTitle) {
    return _box.values.any(
      (budget) => budget.categoryTitle == categoryTitle,
    );
  }

  /// Deletes any budgets matching the given category title.
  Future<void> deleteBudgetsForCategory(String categoryTitle) async {
    final matching = _box.values
        .where((budget) => budget.categoryTitle == categoryTitle)
        .toList();

    for (final budget in matching) {
      await budget.delete();
    }
  }

  /// Renames the category title across matching budgets.
  Future<void> renameBudgetCategory(String oldTitle, String newTitle) async {
    final matching = _box.values
        .where((budget) => budget.categoryTitle == oldTitle)
        .toList();

    for (final budget in matching) {
      budget.categoryTitle = newTitle;
      await budget.save();
    }
  }
}
