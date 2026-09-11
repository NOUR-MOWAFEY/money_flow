import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class HiveService {
  // Singleton: one instance for the whole app lifetime
  HiveService._();
  static final HiveService instance = HiveService._();
  factory HiveService() => instance;
  static const String _trabsactionsBoxName = 'transactions';
  static const String _categoriesBoxName = 'categories';
  static const String _budgetsBoxName = 'budgets';
  static const String _recurringTransactionsBoxName = 'recurring_transactions';
  static const String _userBoxName = 'user';

  // ------------------------------
  //   user box
  // ------------------------------

  static Box get _userBox {
    return Hive.box(_userBoxName);
  }

  // ------------------------------
  //   isFirstTime (via UserModel)
  // ------------------------------

  // get is first time
  static bool get isFirstTime {
    return getUserModel()?.isFirstTime ?? true;
  }

  // set is first time
  static Future<void> setIsFirstTime(bool value) async {
    final user = getUserModel();
    if (user != null) {
      user.isFirstTime = value;
      await user.save();
    } else {
      await saveUserModel(UserModel(name: 'User', isFirstTime: value));
    }
  }

  static Future<void> setNotFirstTime() async {
    await setIsFirstTime(false);
  }

  // ------------------------------
  //   user model (typed)
  // ------------------------------

  static const String _userModelKey = 'userModel';

  // save UserModel
  static Future<void> saveUserModel(UserModel user) async {
    await _userBox.put(_userModelKey, user);
  }

  // get UserModel (returns null if not set yet)
  static UserModel? getUserModel() {
    return _userBox.get(_userModelKey) as UserModel?;
  }

  // update UserModel fields
  static Future<void> updateUserModel({
    String? name,
    String? imagePath,
    String? defaultCurrency,
    bool? isFirstTime,
  }) async {
    final existing = getUserModel();
    if (existing == null) return;
    final updated = existing.copyWith(
      name: name,
      imagePath: imagePath,
      defaultCurrency: defaultCurrency,
      isFirstTime: isFirstTime,
    );
    await saveUserModel(updated);
  }

  // watch UserModel for real-time changes
  static Stream<BoxEvent> watchUserModel() =>
      _userBox.watch(key: _userModelKey);

  // delete UserModel
  static Future<void> deleteUserModel() async {
    await _userBox.delete(_userModelKey);
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

  // add all
  Future<void> addTransactions(List<TransactionModel> transactions) async {
    await _transactionsBox.addAll(transactions);
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

  // add all categories
  Future<void> addCategories(List<CategoryModel> categories) async {
    await _categoriesBox.addAll(categories);
  }

  // delete category
  Future<void> deleteCategory(CategoryModel category) async {
    if (!category.isInBox) return;

    final categoryTitle = category.title;
    final isExpense = category.categoryType == CategoryType.expenses;

    await category.delete();

    // Reassign transactions using this category to deletedCategory
    final matchingTransactions = _transactionsBox.values
        .where((t) => t.title == categoryTitle && t.isExpense == isExpense)
        .toList();

    for (var transaction in matchingTransactions) {
      transaction.title = AppCategories.deletedCategory.title;
      await transaction.save();
    }

    final matchingRecurring = _recurringTransactionsBox.values
        .where(
          (r) =>
              (r.categoryTitle == categoryTitle || r.title == categoryTitle) &&
              r.type ==
                  (isExpense ? CategoryType.expenses : CategoryType.income),
        )
        .toList();

    for (var recurring in matchingRecurring) {
      recurring.categoryTitle = AppCategories.deletedCategory.title;
      recurring.title = AppCategories.deletedCategory.title;
      await recurring.save();
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
      final matchingTransactions = _transactionsBox.values
          .where((t) => t.title == oldTitle && t.isExpense == oldIsExpense)
          .toList();

      for (var transaction in matchingTransactions) {
        transaction.title = newTitle;
        transaction.isExpense = newIsExpense;
        await transaction.save();
      }

      final matchingRecurring = _recurringTransactionsBox.values
          .where(
            (r) =>
                (r.categoryTitle == oldTitle || r.title == oldTitle) &&
                r.type ==
                    (oldIsExpense
                        ? CategoryType.expenses
                        : CategoryType.income),
          )
          .toList();

      for (var recurring in matchingRecurring) {
        recurring.categoryTitle = newTitle;
        recurring.title = newTitle;
        recurring.type = newIsExpense
            ? CategoryType.expenses
            : CategoryType.income;
        await recurring.save();
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

  Future<void> addBudgets(List<BudgetModel> budgets) async {
    await _budgetsBox.addAll(budgets);
  }

  Future<void> clearBudgets() async {
    await _budgetsBox.clear();
  }

  Future<void> deleteBudget(BudgetModel budget) async {
    await budget.delete();
  }

  List<BudgetModel> getBudgets([BudgetPeriod? period]) {
    switch (period) {
      case BudgetPeriod.weekly:
        return _budgetsBox.values
            .where((budget) => budget.period == BudgetPeriod.weekly)
            .toList();

      case BudgetPeriod.monthly:
        return _budgetsBox.values
            .where((budget) => budget.period == BudgetPeriod.monthly)
            .toList();
      case null:
        return _budgetsBox.values.toList();
    }
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

  // ------------------------------
  //   recurring transactions
  // ------------------------------

  Box<RecurringTransactionModel> get _recurringTransactionsBox {
    return Hive.box<RecurringTransactionModel>(_recurringTransactionsBoxName);
  }

  // add
  Future<void> addRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) async {
    await _recurringTransactionsBox.add(recurringTransaction);
  }

  // add all
  Future<void> addRecurringTransactions(
    List<RecurringTransactionModel> recurringTransactions,
  ) async {
    await _recurringTransactionsBox.addAll(recurringTransactions);
  }

  // clear all
  Future<void> clearRecurringTransactions() async {
    await _recurringTransactionsBox.clear();
  }

  // delete
  Future<void> deleteRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) async {
    await recurringTransaction.delete();
  }

  // get
  List<RecurringTransactionModel> getRecurringTransactions() {
    return _recurringTransactionsBox.values.toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  // watch
  Stream<BoxEvent> watchRecurringTransactions() =>
      _recurringTransactionsBox.watch();

  // update
  Future<void> updateRecurringTransaction(
    RecurringTransactionModel recurringTransaction, {
    String? title,
    double? amount,
    CategoryType? type,
    RecurrenceFrequency? frequency,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    String? categoryTitle,
    DateTime? nextOccurrence,
    String? note,
  }) async {
    if (title != null) recurringTransaction.title = title;
    if (amount != null) recurringTransaction.amount = amount;
    if (type != null) recurringTransaction.type = type;
    if (frequency != null) recurringTransaction.frequency = frequency;
    if (startDate != null) recurringTransaction.startDate = startDate;
    if (endDate != null) recurringTransaction.endDate = endDate;
    if (isActive != null) recurringTransaction.isActive = isActive;
    if (categoryTitle != null) {
      recurringTransaction.categoryTitle = categoryTitle;
    }
    if (nextOccurrence != null) {
      recurringTransaction.nextOccurrence = nextOccurrence;
    }
    if (note != null) recurringTransaction.note = note;

    await recurringTransaction.save();
  }

  // toggle active
  Future<void> toggleRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) async {
    recurringTransaction.isActive = !recurringTransaction.isActive;
    await recurringTransaction.save();
  }
}
