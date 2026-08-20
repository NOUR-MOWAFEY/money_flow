import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class HiveService {
  // Singleton: one instance for the whole app lifetime
  HiveService._();
  static final HiveService instance = HiveService._();
  factory HiveService() => instance;
  static const String _trabsactionsBoxName = 'transactions';
  static const String _categoriesBoxName = 'categories';
  static const String _budgetsBoxName = 'budgets';
  static const String _userBoxName = 'user';
  static const String _isFirstTime = 'isFirstTime';
  static const String _name = 'name';
  static const String _image = 'image';

  // ------------------------------
  //   user
  // ------------------------------

  static Box get _userBox {
    return Hive.box(_userBoxName);
  }

  // get is first time
  static bool get isFirstTime {
    return _userBox.get(_isFirstTime, defaultValue: true);
  }

  // set is first time
  static Future<void> setNotFirstTime() async {
    await _userBox.put(_isFirstTime, false);
  }

  // save user
  static Future<void> saveUser(String name, String image) async {
    await _userBox.put(_name, name);
    await _userBox.put(_image, image);
  }

  // get user name
  static String get userName {
    return _userBox.get(_name, defaultValue: '');
  }

  // get user image
  static String get userImage {
    return _userBox.get(_image, defaultValue: '');
  }

  // ------------------------------
  //   transactions
  // ------------------------------

  Box<TransactionModel> get _transactionsBox {
    return Hive.box<TransactionModel>(_trabsactionsBoxName);
  }

  // add
  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionsBox.add(transaction);
  }

  //delete
  Future<void> deleteTransaction(TransactionModel transaction) async {
    await transaction.delete();
  }

  // get
  List<TransactionModel> getTransactions() {
    return _transactionsBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // watch transactions box for real-time changes
  Stream<BoxEvent> watchTransactions() => _transactionsBox.watch();

  // edit
  Future<void> editTransaction(
    TransactionModel transaction, {
    String? title,
    double? amount,
    bool? isExpense,
    DateTime? date,
  }) async {
    if (title != null) transaction.title = title;
    if (amount != null) transaction.amount = amount;
    if (isExpense != null) transaction.isExpense = isExpense;
    if (date != null) transaction.date = date;

    await transaction.save();
  }

  // clear
  Future<void> reset() async {
    await _transactionsBox.clear();
  }

  // get expenses
  static List<TransactionModel> getExpenses(
    List<TransactionModel> transactions,
  ) {
    List<TransactionModel> expenses = [];
    for (var transaction in transactions) {
      if (transaction.isExpense) {
        expenses.add(transaction);
      }
    }
    return expenses;
  }

  // get income
  static List<TransactionModel> getIncome(List<TransactionModel> transactions) {
    List<TransactionModel> income = [];
    for (var transaction in transactions) {
      if (!transaction.isExpense) {
        income.add(transaction);
      }
    }
    return income;
  }

  // ------------------------------
  //   categories
  // ------------------------------

  Box<CategoryModel> get _categoriesBox {
    return Hive.box<CategoryModel>(_categoriesBoxName);
  }

  // add category
  Future<void> addCategory(CategoryModel category) async {
    await _categoriesBox.add(category);
  }

  // delete category
  Future<void> deleteCategory(CategoryModel category) async {
    if (!category.isInBox) return;

    final categoryTitle = category.title;
    final isExpense = category.categoryType == CategoryType.expenses;

    await category.delete();

    // Reassign transactions using this category to deletedCategory
    final matchingTransactions = _transactionsBox.values.where(
      (t) => t.title == categoryTitle && t.isExpense == isExpense,
    ).toList();

    for (var transaction in matchingTransactions) {
      transaction.title = AppCategories.deletedCategory.title;
      await transaction.save();
    }

    await _deleteBudgetsForCategory(categoryTitle);
  }

  // get all categories
  List<CategoryModel> getCategories() {
    return _categoriesBox.values.toList();
  }

  // watch categories box for real-time changes
  Stream<BoxEvent> watchCategories() => _categoriesBox.watch();

  // get categories by type
  List<CategoryModel> getCategoriesByType(CategoryType type) {
    return _categoriesBox.values
        .where((category) => category.categoryType == type)
        .toList();
  }

  // get expense categories
  List<CategoryModel> getExpenseCategories() {
    return getCategoriesByType(CategoryType.expenses);
  }

  // get income categories
  List<CategoryModel> getIncomeCategories() {
    return getCategoriesByType(CategoryType.income);
  }

  // update category
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
      final matchingTransactions = _transactionsBox.values.where(
        (t) => t.title == oldTitle && t.isExpense == oldIsExpense,
      ).toList();

      for (var transaction in matchingTransactions) {
        transaction.title = newTitle;
        transaction.isExpense = newIsExpense;
        await transaction.save();
      }

      if (oldIsExpense && oldTitle != newTitle) {
        await _renameBudgetCategory(oldTitle, newTitle);
      }
    }
  }

  // clear all categories
  Future<void> clearCategories() async {
    await _categoriesBox.clear();
  }

  // ------------------------------
  //   budgets
  // ------------------------------

  Box<BudgetModel> get _budgetsBox {
    return Hive.box<BudgetModel>(_budgetsBoxName);
  }

  Future<void> addBudget(BudgetModel budget) async {
    await _budgetsBox.add(budget);
  }

  Future<void> deleteBudget(BudgetModel budget) async {
    await budget.delete();
  }

  List<BudgetModel> getBudgets() {
    return _budgetsBox.values.toList();
  }

  Stream<BoxEvent> watchBudgets() => _budgetsBox.watch();

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

  bool hasBudgetForCategory(String categoryTitle) {
    return _budgetsBox.values.any(
      (budget) => budget.categoryTitle == categoryTitle,
    );
  }

  Future<void> _deleteBudgetsForCategory(String categoryTitle) async {
    final matchingBudgets = _budgetsBox.values
        .where((budget) => budget.categoryTitle == categoryTitle)
        .toList();

    for (final budget in matchingBudgets) {
      await budget.delete();
    }
  }

  Future<void> _renameBudgetCategory(String oldTitle, String newTitle) async {
    final matchingBudgets = _budgetsBox.values
        .where((budget) => budget.categoryTitle == oldTitle)
        .toList();

    for (final budget in matchingBudgets) {
      budget.categoryTitle = newTitle;
      await budget.save();
    }
  }
}
