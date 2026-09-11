import 'package:flutter/material.dart';

enum TransactionDateFilter {
  allTime('All Time'),
  today('Today'),
  thisWeek('This Week'),
  thisMonth('This Month'),
  custom('Custom Range');

  const TransactionDateFilter(this.label);

  final String label;

  bool get isAllTime => this == TransactionDateFilter.allTime;
  bool get isCustom => this == TransactionDateFilter.custom;

  bool matches(DateTime targetDate, {DateTimeRange? customRange}) {
    final date = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (this) {
      case TransactionDateFilter.allTime:
        return true;

      case TransactionDateFilter.today:
        return date.isAtSameMomentAs(today);

      case TransactionDateFilter.thisWeek:
        // Week starting Monday
        final weekStart = today.subtract(Duration(days: today.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        return !date.isBefore(weekStart) && !date.isAfter(weekEnd);

      case TransactionDateFilter.thisMonth:
        return date.year == today.year && date.month == today.month;

      case TransactionDateFilter.custom:
        if (customRange == null) return true;
        final start = DateTime(
          customRange.start.year,
          customRange.start.month,
          customRange.start.day,
        );
        final end = DateTime(
          customRange.end.year,
          customRange.end.month,
          customRange.end.day,
          23,
          59,
          59,
        );
        return !targetDate.isBefore(start) && !targetDate.isAfter(end);
    }
  }
}
