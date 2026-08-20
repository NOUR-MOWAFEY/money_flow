import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/features/budget/data/models/budget_limit_item.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class BudgetDataHelper {
  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static bool isInPeriod(DateTime date, BudgetPeriod period) {
    final today = _dateOnly(DateTime.now());
    final normalizedDate = _dateOnly(date);

    switch (period) {
      case BudgetPeriod.weekly:
        final weekStart = today.subtract(Duration(days: today.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        return !normalizedDate.isBefore(weekStart) &&
            !normalizedDate.isAfter(weekEnd);
      case BudgetPeriod.monthly:
        final now = DateTime.now();
        return date.year == now.year && date.month == now.month;
    }
  }

  static double spentForCategory(
    List<TransactionModel> transactions,
    String categoryTitle,
    BudgetPeriod period,
  ) {
    return transactions
        .where(
          (transaction) =>
              transaction.isExpense &&
              transaction.title == categoryTitle &&
              isInPeriod(transaction.date, period),
        )
        .fold<double>(0, (sum, transaction) => sum + transaction.amount);
  }

  static List<BudgetLimitItem> buildBudgetItems({
    required List<BudgetModel> budgets,
    required List<TransactionModel> transactions,
    required HiveService hiveService,
  }) {
    return budgets.map((budget) {
      final category = getCategory(budget.categoryTitle, true, hiveService);
      final spent = spentForCategory(
        transactions,
        budget.categoryTitle,
        budget.period,
      );

      return BudgetLimitItem(
        budget: budget,
        title: budget.categoryTitle,
        icon: category.icon,
        iconColor: category.color,
        spent: spent,
        limit: budget.limitAmount,
        period: budget.period,
      );
    }).toList()
      ..sort((a, b) => b.percentage.compareTo(a.percentage));
  }
}
