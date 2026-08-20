import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/reports/data/models/income_expense_bar_data.dart';
import 'package:money_flow/features/reports/data/models/pie_chart_item.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class ReportsDataHelper {
  static const _fallbackColors = [
    Color(0xFF4E9F3D),
    AppColors.primary,
    Color(0xFFE5A93C),
    Color(0xFFE84545),
    Color(0xFF4A90D9),
    Color(0xFF8E24AA),
    Color(0xFF00ACC1),
    Color(0xFFFF6B35),
  ];

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static List<TransactionModel> filterByPeriod(
    List<TransactionModel> transactions,
    ReportPeriod period,
  ) {
    final today = _dateOnly(DateTime.now());

    switch (period) {
      case ReportPeriod.daily:
        final start = today.subtract(const Duration(days: 6));
        return transactions.where((transaction) {
          final date = _dateOnly(transaction.date);
          return !date.isBefore(start) && !date.isAfter(today);
        }).toList();
      case ReportPeriod.weekly:
        final currentWeekStart = today.subtract(Duration(days: today.weekday - 1));
        final start = currentWeekStart.subtract(const Duration(days: 7 * 5));
        return transactions.where((transaction) {
          final date = _dateOnly(transaction.date);
          return !date.isBefore(start) && !date.isAfter(today);
        }).toList();
      case ReportPeriod.monthly:
        final start = DateTime(today.year, today.month - 5, 1);
        return transactions.where((transaction) {
          final date = _dateOnly(transaction.date);
          return !date.isBefore(start) && !date.isAfter(today);
        }).toList();
    }
  }

  static List<IncomeExpenseBarData> buildBarChartData(
    List<TransactionModel> transactions,
    ReportPeriod period,
  ) {
    final now = DateTime.now();
    final today = _dateOnly(now);

    switch (period) {
      case ReportPeriod.daily:
        return List.generate(7, (index) {
          final day = today.subtract(Duration(days: 6 - index));
          final dayTransactions = transactions.where(
            (transaction) => _dateOnly(transaction.date) == day,
          );
          return IncomeExpenseBarData(
            label: DateFormat('EEE').format(day),
            income: _sumIncome(dayTransactions),
            expense: _sumExpense(dayTransactions),
          );
        });
      case ReportPeriod.weekly:
        final currentWeekStart = today.subtract(Duration(days: today.weekday - 1));
        return List.generate(6, (index) {
          final weekStart = currentWeekStart.subtract(
            Duration(days: (5 - index) * 7),
          );
          final weekEnd = weekStart.add(const Duration(days: 6));
          final weekTransactions = transactions.where((transaction) {
            final date = _dateOnly(transaction.date);
            return !date.isBefore(weekStart) && !date.isAfter(weekEnd);
          });
          return IncomeExpenseBarData(
            label: DateFormat('d/M').format(weekStart),
            income: _sumIncome(weekTransactions),
            expense: _sumExpense(weekTransactions),
          );
        });
      case ReportPeriod.monthly:
        return List.generate(6, (index) {
          final month = DateTime(now.year, now.month - (5 - index), 1);
          final monthTransactions = transactions.where((transaction) {
            final date = transaction.date;
            return date.year == month.year && date.month == month.month;
          });
          return IncomeExpenseBarData(
            label: DateFormat('MMM').format(month),
            income: _sumIncome(monthTransactions),
            expense: _sumExpense(monthTransactions),
          );
        });
    }
  }

  static List<PieChartItem> buildPieChartData(
    List<TransactionModel> transactions,
    ReportPeriod period,
  ) {
    final filtered = filterByPeriod(transactions, period);
    final totalsByCategory = <String, double>{};

    for (final transaction in filtered.where((t) => t.isExpense)) {
      totalsByCategory[transaction.title] =
          (totalsByCategory[transaction.title] ?? 0) + transaction.amount;
    }

    if (totalsByCategory.isEmpty) {
      return [];
    }

    final total = totalsByCategory.values.fold<double>(0, (sum, value) => sum + value);

    final items = totalsByCategory.entries.map((entry) {
      return PieChartItem(
        title: entry.key,
        value: (entry.value / total) * 100,
        color: _colorForCategory(entry.key),
      );
    }).toList();

    items.sort((a, b) => b.value.compareTo(a.value));
    return items;
  }

  static double _sumIncome(Iterable<TransactionModel> transactions) =>
      transactions
          .where((transaction) => !transaction.isExpense)
          .fold<double>(0, (sum, transaction) => sum + transaction.amount);

  static double _sumExpense(Iterable<TransactionModel> transactions) =>
      transactions
          .where((transaction) => transaction.isExpense)
          .fold<double>(0, (sum, transaction) => sum + transaction.amount);

  static Color _colorForCategory(String title) {
    for (final category in AppCategories.expenseCategories) {
      if (category.title == title) {
        return category.color;
      }
    }

    return _fallbackColors[title.hashCode.abs() % _fallbackColors.length];
  }
}
