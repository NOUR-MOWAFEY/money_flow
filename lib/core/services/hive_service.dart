import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/services/storage/budget_storage_service.dart';
import 'package:money_flow/core/services/storage/category_storage_service.dart';
import 'package:money_flow/core/services/storage/recurring_storage_service.dart';
import 'package:money_flow/core/services/storage/transaction_storage_service.dart';
import 'package:money_flow/core/services/storage/user_storage_service.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/data/models/icon_data_adapter.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

// Re-export individual domain storage services for modular usage
export 'package:money_flow/core/services/storage/budget_storage_service.dart';
export 'package:money_flow/core/services/storage/category_storage_service.dart';
export 'package:money_flow/core/services/storage/recurring_storage_service.dart';
export 'package:money_flow/core/services/storage/transaction_storage_service.dart';
export 'package:money_flow/core/services/storage/user_storage_service.dart';

/// Central Facade coordinating Hive storage across all application domains.
///
/// Under the hood, operations are delegated to domain-specific services:
/// - [UserStorageService] for user profile and onboarding settings
/// - [TransactionStorageService] for transactions
/// - [CategoryStorageService] for categories and cascading updates
/// - [BudgetStorageService] for budgets
/// - [RecurringStorageService] for recurring transaction schedules
class HiveService {
  // Domain storage services
  final UserStorageService userStorage;
  final TransactionStorageService transactionStorage;
  final CategoryStorageService categoryStorage;
  final BudgetStorageService budgetStorage;
  final RecurringStorageService recurringStorage;

  HiveService._({
    UserStorageService? userStorage,
    TransactionStorageService? transactionStorage,
    BudgetStorageService? budgetStorage,
    RecurringStorageService? recurringStorage,
    CategoryStorageService? categoryStorage,
  })  : userStorage = userStorage ?? const UserStorageService(),
        transactionStorage =
            transactionStorage ?? const TransactionStorageService(),
        budgetStorage = budgetStorage ?? const BudgetStorageService(),
        recurringStorage =
            recurringStorage ?? const RecurringStorageService(),
        categoryStorage = categoryStorage ??
            CategoryStorageService(
              transactionStorage:
                  transactionStorage ?? const TransactionStorageService(),
              recurringStorage:
                  recurringStorage ?? const RecurringStorageService(),
              budgetStorage: budgetStorage ?? const BudgetStorageService(),
            );

  static final HiveService instance = HiveService._();
  factory HiveService() => instance;

  static const UserStorageService _defaultUserStorage = UserStorageService();

  // ------------------------------
  //   Box Names
  // ------------------------------
  static const String transactionsBoxName = TransactionStorageService.boxName;
  static const String categoriesBoxName = CategoryStorageService.boxName;
  static const String budgetsBoxName = BudgetStorageService.boxName;
  static const String recurringTransactionsBoxName =
      RecurringStorageService.boxName;
  static const String userBoxName = UserStorageService.boxName;

  // ------------------------------
  //   Initialization & Adapters
  // ------------------------------

  /// Registers all model adapters required by the application.
  /// Safely checks [Hive.isAdapterRegistered] so calling multiple times is a no-op.
  static void registerAdapters() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(CategoryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(IconDataAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(ColorAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(BudgetModelAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(BudgetPeriodAdapter());
    }
    if (!Hive.isAdapterRegistered(8)) {
      Hive.registerAdapter(RecurringTransactionModelAdapter());
    }
    if (!Hive.isAdapterRegistered(9)) {
      Hive.registerAdapter(RecurrenceFrequencyAdapter());
    }
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  }

  /// Opens all application Hive boxes concurrently.
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<TransactionModel>(transactionsBoxName),
      Hive.openBox<CategoryModel>(categoriesBoxName),
      Hive.openBox<BudgetModel>(budgetsBoxName),
      Hive.openBox<RecurringTransactionModel>(recurringTransactionsBoxName),
      Hive.openBox(userBoxName),
    ]);
  }

  /// Registers all adapters and opens all boxes.
  static Future<void> init() async {
    registerAdapters();
    await openBoxes();
  }

  // ------------------------------
  //   User Box & Profile
  // ------------------------------

  UserModel? get currentUser => userStorage.currentUser;

  static bool get isFirstTime => _defaultUserStorage.isFirstTime;

  static Future<void> setIsFirstTime(bool value) =>
      _defaultUserStorage.setIsFirstTime(value);

  static Future<void> setNotFirstTime() =>
      _defaultUserStorage.setNotFirstTime();

  static Future<void> saveUserModel(UserModel user) =>
      _defaultUserStorage.saveUserModel(user);

  static UserModel? getUserModel() => _defaultUserStorage.getUserModel();

  static Future<void> updateUserModel({
    String? name,
    String? imagePath,
    String? defaultCurrency,
    bool? isFirstTime,
  }) =>
      _defaultUserStorage.updateUserModel(
        name: name,
        imagePath: imagePath,
        defaultCurrency: defaultCurrency,
        isFirstTime: isFirstTime,
      );

  static Stream<BoxEvent> watchUserModel() =>
      _defaultUserStorage.watchUserModel();

  static Future<void> deleteUserModel() =>
      _defaultUserStorage.deleteUserModel();

  // ------------------------------
  //   Transactions
  // ------------------------------

  Future<void> addTransaction(TransactionModel transaction) =>
      transactionStorage.addTransaction(transaction);

  Future<void> addTransactions(List<TransactionModel> items) =>
      transactionStorage.addTransactions(items);

  Future<void> deleteTransaction(TransactionModel transaction) =>
      transactionStorage.deleteTransaction(transaction);

  List<TransactionModel> getTransactions() =>
      transactionStorage.getTransactions();

  Stream<BoxEvent> watchTransactions() =>
      transactionStorage.watchTransactions();

  Future<void> editTransaction(
    TransactionModel transaction, {
    String? title,
    double? amount,
    bool? isExpense,
    DateTime? date,
  }) =>
      transactionStorage.editTransaction(
        transaction,
        title: title,
        amount: amount,
        isExpense: isExpense,
        date: date,
      );

  Future<void> clearTransactions() => transactionStorage.clearTransactions();

  Future<void> reset() => transactionStorage.reset();

  // ------------------------------
  //   Categories
  // ------------------------------

  Future<void> addCategory(CategoryModel category) =>
      categoryStorage.addCategory(category);

  Future<void> addCategories(List<CategoryModel> items) =>
      categoryStorage.addCategories(items);

  Future<void> deleteCategory(CategoryModel category) =>
      categoryStorage.deleteCategory(category);

  List<CategoryModel> getCategories() => categoryStorage.getCategories();

  Stream<BoxEvent> watchCategories() => categoryStorage.watchCategories();

  List<CategoryModel> getCategoriesByType(CategoryType type) =>
      categoryStorage.getCategoriesByType(type);

  List<CategoryModel> getExpenseCategories() =>
      categoryStorage.getExpenseCategories();

  Future<void> updateCategory(
    CategoryModel category, {
    String? title,
    IconData? icon,
    Color? color,
    CategoryType? categoryType,
  }) =>
      categoryStorage.updateCategory(
        category,
        title: title,
        icon: icon,
        color: color,
        categoryType: categoryType,
      );

  Future<void> clearCategories() => categoryStorage.clearCategories();

  // ------------------------------
  //   Budgets
  // ------------------------------

  Future<void> addBudget(BudgetModel budget) => budgetStorage.addBudget(budget);

  Future<void> addBudgets(List<BudgetModel> items) =>
      budgetStorage.addBudgets(items);

  Future<void> clearBudgets() => budgetStorage.clearBudgets();

  Future<void> deleteBudget(BudgetModel budget) =>
      budgetStorage.deleteBudget(budget);

  List<BudgetModel> getBudgets([BudgetPeriod? period]) =>
      budgetStorage.getBudgets(period);

  Stream<BoxEvent> watchBudgets() => budgetStorage.watchBudgets();

  Future<void> updateBudget(
    BudgetModel budget, {
    String? categoryTitle,
    double? limitAmount,
    BudgetPeriod? period,
  }) =>
      budgetStorage.updateBudget(
        budget,
        categoryTitle: categoryTitle,
        limitAmount: limitAmount,
        period: period,
      );

  bool hasBudgetForCategory(String categoryTitle) =>
      budgetStorage.hasBudgetForCategory(categoryTitle);

  // ------------------------------
  //   Recurring Transactions
  // ------------------------------

  Future<void> addRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) =>
      recurringStorage.addRecurringTransaction(recurringTransaction);

  Future<void> addRecurringTransactions(
    List<RecurringTransactionModel> items,
  ) =>
      recurringStorage.addRecurringTransactions(items);

  Future<void> clearRecurringTransactions() =>
      recurringStorage.clearRecurringTransactions();

  Future<void> deleteRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) =>
      recurringStorage.deleteRecurringTransaction(recurringTransaction);

  List<RecurringTransactionModel> getRecurringTransactions() =>
      recurringStorage.getRecurringTransactions();

  Stream<BoxEvent> watchRecurringTransactions() =>
      recurringStorage.watchRecurringTransactions();

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
  }) =>
      recurringStorage.updateRecurringTransaction(
        recurringTransaction,
        title: title,
        amount: amount,
        type: type,
        frequency: frequency,
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
        categoryTitle: categoryTitle,
        nextOccurrence: nextOccurrence,
        note: note,
      );

  Future<void> toggleRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) =>
      recurringStorage.toggleRecurringTransaction(recurringTransaction);
}
