import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

/// Storage service dedicated to managing transactions.
class TransactionStorageService {
  const TransactionStorageService();

  static const String boxName = 'transactions';

  Box<TransactionModel> get _box => Hive.box<TransactionModel>(boxName);

  /// Adds a single transaction.
  Future<void> addTransaction(TransactionModel transaction) async {
    await _box.add(transaction);
  }

  /// Adds multiple transactions.
  Future<void> addTransactions(List<TransactionModel> transactions) async {
    await _box.addAll(transactions);
  }

  /// Deletes a transaction.
  Future<void> deleteTransaction(TransactionModel transaction) async {
    await transaction.delete();
  }

  /// Retrieves all transactions sorted by date descending (newest first).
  List<TransactionModel> getTransactions() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Real-time stream of transaction changes.
  Stream<BoxEvent> watchTransactions() => _box.watch();

  /// Edits an existing transaction's fields.
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

  /// Clears all transactions from the box.
  Future<void> clearTransactions() async {
    await _box.clear();
  }

  /// Alias for [clearTransactions] for backwards compatibility.
  Future<void> reset() => clearTransactions();

  /// Synchronizes existing transactions when a category is renamed or converted.
  Future<void> reassignCategory(
    String oldTitle,
    String newTitle, {
    required bool isExpense,
    bool? newIsExpense,
  }) async {
    final matching = _box.values
        .where((t) => t.title == oldTitle && t.isExpense == isExpense)
        .toList();

    for (final transaction in matching) {
      transaction.title = newTitle;
      if (newIsExpense != null) {
        transaction.isExpense = newIsExpense;
      }
      await transaction.save();
    }
  }

  /// Reassigns transactions to a fallback title when their category is deleted.
  Future<void> reassignDeletedCategory(
    String categoryTitle, {
    required bool isExpense,
    required String fallbackTitle,
  }) async {
    final matching = _box.values
        .where((t) => t.title == categoryTitle && t.isExpense == isExpense)
        .toList();

    for (final transaction in matching) {
      transaction.title = fallbackTitle;
      await transaction.save();
    }
  }
}
