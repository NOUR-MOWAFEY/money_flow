import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/services/storage/transaction_storage_service.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';

/// Storage service dedicated to managing isolated environments and their expenses.
class EnvironmentStorageService {
  final TransactionStorageService transactionStorage;

  const EnvironmentStorageService({
    this.transactionStorage = const TransactionStorageService(),
  });

  static const String boxName = 'environments';
  static const String expensesBoxName = 'environment_expenses';

  Box<EnvironmentModel> get _envBox => Hive.box<EnvironmentModel>(boxName);
  Box<EnvironmentExpenseModel> get _expenseBox =>
      Hive.box<EnvironmentExpenseModel>(expensesBoxName);

  /// Retrieves all environments sorted with active first, then by creation date.
  List<EnvironmentModel> getEnvironments() {
    final list = _envBox.values.toList();
    list.sort((a, b) {
      if (a.isClosed != b.isClosed) {
        return a.isClosed ? 1 : -1;
      }
      return b.createdAt.compareTo(a.createdAt);
    });
    return list;
  }

  /// Retrieves a specific environment by its id.
  EnvironmentModel? getEnvironment(String id) {
    try {
      return _envBox.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Stream of changes to the environments box.
  Stream<BoxEvent> watchEnvironments() => _envBox.watch();

  /// Stream of changes to the environment expenses box.
  Stream<BoxEvent> watchExpenses() => _expenseBox.watch();

  /// Adds a new environment.
  Future<void> addEnvironment(EnvironmentModel environment) async {
    await _envBox.put(environment.id, environment);
  }

  /// Updates an environment.
  Future<void> updateEnvironment(EnvironmentModel environment) async {
    await environment.save();
  }

  /// Checks whether an environment exists and is active.
  bool isEnvironmentActive({String? environmentId, String? environmentName}) {
    if (environmentId != null && environmentId.isNotEmpty) {
      return getEnvironment(environmentId) != null;
    }
    if (environmentName != null && environmentName.isNotEmpty) {
      final trimmed = environmentName.trim().toLowerCase();
      return _envBox.values.any((e) => e.name.trim().toLowerCase() == trimmed);
    }
    return false;
  }

  /// Deletes an environment along with all its recorded expenses.
  /// If [deleteTransactions] is true, also deletes any linked transactions from the main ledger.
  Future<void> deleteEnvironment(
    String id, {
    bool deleteTransactions = false,
  }) async {
    // Delete associated expenses
    final expensesToDelete = _expenseBox.values
        .where((exp) => exp.environmentId == id)
        .map((exp) => exp.key)
        .toList();

    for (final key in expensesToDelete) {
      await _expenseBox.delete(key);
    }

    if (deleteTransactions) {
      await transactionStorage.deleteTransactionsForEnvironment(id);
    }

    await _envBox.delete(id);
  }

  /// Retrieves all expenses for a given environment id.
  List<EnvironmentExpenseModel> getExpensesForEnvironment(
    String environmentId,
  ) {
    final list = _expenseBox.values
        .where((exp) => exp.environmentId == environmentId)
        .toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// Records an expense inside an environment and updates its balance.
  Future<void> addExpense(
    EnvironmentExpenseModel expense,
    EnvironmentModel environment,
  ) async {
    await _expenseBox.put(expense.id, expense);
    environment.currentBalance -= expense.amount;
    await environment.save();
  }

  /// Deletes an expense and restores the environment's balance.
  Future<void> deleteExpense(
    EnvironmentExpenseModel expense,
    EnvironmentModel environment,
  ) async {
    environment.currentBalance += expense.amount;
    await environment.save();
    await expense.delete();
  }

  /// Updates an existing expense and adjusts the environment's balance.
  Future<void> updateExpense(
    EnvironmentExpenseModel expense,
    EnvironmentModel environment, {
    String? title,
    double? amount,
    DateTime? date,
  }) async {
    if (amount != null && amount != expense.amount) {
      final difference = amount - expense.amount;
      environment.currentBalance -= difference;
      await environment.save();
      expense.amount = amount;
    }
    if (title != null) expense.title = title;
    if (date != null) expense.date = date;
    await expense.save();
  }

  /// Tops up an environment with extra funds.
  Future<void> topUpEnvironment(
    EnvironmentModel environment,
    double amount,
  ) async {
    environment.initialAmount += amount;
    environment.currentBalance += amount;
    await environment.save();
  }

  /// Closes an environment.
  Future<void> closeEnvironment(EnvironmentModel environment) async {
    environment.isClosed = true;
    await environment.save();
  }
}
