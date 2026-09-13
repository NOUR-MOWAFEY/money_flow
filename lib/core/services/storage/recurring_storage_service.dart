import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';

/// Storage service dedicated to managing recurring transactions.
class RecurringStorageService {
  const RecurringStorageService();

  static const String boxName = 'recurring_transactions';

  Box<RecurringTransactionModel> get _box =>
      Hive.box<RecurringTransactionModel>(boxName);

  /// Adds a recurring transaction.
  Future<void> addRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) async {
    await _box.add(recurringTransaction);
  }

  /// Adds multiple recurring transactions.
  Future<void> addRecurringTransactions(
    List<RecurringTransactionModel> recurringTransactions,
  ) async {
    await _box.addAll(recurringTransactions);
  }

  /// Clears all recurring transactions.
  Future<void> clearRecurringTransactions() async {
    await _box.clear();
  }

  /// Deletes a recurring transaction.
  Future<void> deleteRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) async {
    await recurringTransaction.delete();
  }

  /// Retrieves all recurring transactions sorted by start date descending.
  List<RecurringTransactionModel> getRecurringTransactions() {
    return _box.values.toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  /// Real-time stream of recurring transaction changes.
  Stream<BoxEvent> watchRecurringTransactions() => _box.watch();

  /// Updates fields of a recurring transaction.
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

  /// Toggles active status of a recurring transaction.
  Future<void> toggleRecurringTransaction(
    RecurringTransactionModel recurringTransaction,
  ) async {
    recurringTransaction.isActive = !recurringTransaction.isActive;
    await recurringTransaction.save();
  }

  /// Synchronizes recurring transactions when a category is renamed or converted.
  Future<void> reassignCategory(
    String oldTitle,
    String newTitle, {
    required bool isExpense,
    bool? newIsExpense,
  }) async {
    final targetType = isExpense ? CategoryType.expenses : CategoryType.income;
    final matching = _box.values
        .where(
          (r) =>
              (r.categoryTitle == oldTitle || r.title == oldTitle) &&
              r.type == targetType,
        )
        .toList();

    for (final recurring in matching) {
      recurring.categoryTitle = newTitle;
      recurring.title = newTitle;
      if (newIsExpense != null) {
        recurring.type =
            newIsExpense ? CategoryType.expenses : CategoryType.income;
      }
      await recurring.save();
    }
  }

  /// Reassigns recurring transactions when a category is deleted.
  Future<void> reassignDeletedCategory(
    String categoryTitle, {
    required bool isExpense,
    required String fallbackTitle,
  }) async {
    final targetType = isExpense ? CategoryType.expenses : CategoryType.income;
    final matching = _box.values
        .where(
          (r) =>
              (r.categoryTitle == categoryTitle || r.title == categoryTitle) &&
              r.type == targetType,
        )
        .toList();

    for (final recurring in matching) {
      recurring.categoryTitle = fallbackTitle;
      recurring.title = fallbackTitle;
      await recurring.save();
    }
  }
}
