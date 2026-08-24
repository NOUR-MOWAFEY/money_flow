import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class RecurringProcessorService {
  RecurringProcessorService._();
  static final RecurringProcessorService instance =
      RecurringProcessorService._();
  factory RecurringProcessorService() => instance;

  /// Processes all active recurring transactions and generates TransactionModel
  /// instances using the selected category title for any occurrences due up to the current date.
  Future<int> processDueRecurringTransactions(HiveService hiveService) async {
    final recurringList = hiveService.getRecurringTransactions();
    final now = DateTime.now();
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
    int generatedCount = 0;

    for (final recurring in recurringList) {
      if (!recurring.isActive) continue;

      DateTime currentOccurrence =
          recurring.nextOccurrence ?? recurring.startDate;
      DateTime dateOnlyOccurrence = DateTime(
        currentOccurrence.year,
        currentOccurrence.month,
        currentOccurrence.day,
      );

      bool modified = false;

      while (!dateOnlyOccurrence.isAfter(todayEnd)) {
        if (recurring.endDate != null &&
            dateOnlyOccurrence.isAfter(recurring.endDate!)) {
          recurring.isActive = false;
          modified = true;
          break;
        }

        // Use the selected category title for the transaction so it maps to the right category in transactions/reports
        final transactionTitle =
            (recurring.categoryTitle != null &&
                    recurring.categoryTitle!.isNotEmpty)
                ? recurring.categoryTitle!
                : recurring.title;

        final transaction = TransactionModel(
          title: transactionTitle,
          amount: recurring.amount,
          date: currentOccurrence,
          isExpense: recurring.type == CategoryType.expenses,
        );

        await hiveService.addTransaction(transaction);
        generatedCount++;

        // Advance to next occurrence
        currentOccurrence = _calculateNextOccurrence(
          currentOccurrence,
          recurring.frequency,
        );
        dateOnlyOccurrence = DateTime(
          currentOccurrence.year,
          currentOccurrence.month,
          currentOccurrence.day,
        );
        modified = true;
      }

      if (modified) {
        recurring.nextOccurrence = currentOccurrence;
        if (recurring.endDate != null &&
            dateOnlyOccurrence.isAfter(recurring.endDate!)) {
          recurring.isActive = false;
        }
        await recurring.save();
      }
    }

    return generatedCount;
  }

  DateTime _calculateNextOccurrence(
    DateTime date,
    RecurrenceFrequency frequency,
  ) {
    switch (frequency) {
      case RecurrenceFrequency.daily:
        return DateTime(
          date.year,
          date.month,
          date.day + 1,
          date.hour,
          date.minute,
          date.second,
        );
      case RecurrenceFrequency.weekly:
        return DateTime(
          date.year,
          date.month,
          date.day + 7,
          date.hour,
          date.minute,
          date.second,
        );
      case RecurrenceFrequency.monthly:
        final nextYear = date.year + (date.month ~/ 12);
        final nextMonth = (date.month % 12) + 1;
        final daysInNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
        final nextDay = date.day > daysInNextMonth ? daysInNextMonth : date.day;
        return DateTime(
          nextYear,
          nextMonth,
          nextDay,
          date.hour,
          date.minute,
          date.second,
        );
    }
  }
}
