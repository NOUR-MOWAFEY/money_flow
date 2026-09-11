import 'package:flutter/material.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_date_filter.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_sort_option.dart';
import 'package:money_flow/features/transactions_history/data/models/transaction_type_filter.dart';

class TransactionHistoryFilter {
  const TransactionHistoryFilter({
    this.searchQuery = '',
    this.typeFilter = TransactionTypeFilter.all,
    this.dateFilter = TransactionDateFilter.allTime,
    this.customDateRange,
    this.categoryFilter,
    this.sortOption = TransactionSortOption.dateDesc,
  });

  final String searchQuery;
  final TransactionTypeFilter typeFilter;
  final TransactionDateFilter dateFilter;
  final DateTimeRange? customDateRange;
  final String? categoryFilter;
  final TransactionSortOption sortOption;

  bool get isFiltered {
    return searchQuery.trim().isNotEmpty ||
        typeFilter != TransactionTypeFilter.all ||
        dateFilter != TransactionDateFilter.allTime ||
        categoryFilter != null ||
        sortOption != TransactionSortOption.dateDesc;
  }

  bool matches(TransactionModel transaction) {
    // 1. Search Query
    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      final titleMatches = transaction.title.toLowerCase().contains(query);
      final amountMatches = transaction.amount.toString().contains(query);
      if (!titleMatches && !amountMatches) return false;
    }

    // 2. Type Filter
    if (typeFilter == TransactionTypeFilter.expenses &&
        !transaction.isExpense) {
      return false;
    }
    if (typeFilter == TransactionTypeFilter.income && transaction.isExpense) {
      return false;
    }

    // 3. Category Filter
    if (categoryFilter != null && transaction.title != categoryFilter) {
      return false;
    }

    // 4. Date Filter
    if (!dateFilter.matches(transaction.date, customRange: customDateRange)) {
      return false;
    }

    return true;
  }

  TransactionHistoryFilter copyWith({
    String? searchQuery,
    TransactionTypeFilter? typeFilter,
    TransactionDateFilter? dateFilter,
    DateTimeRange? customDateRange,
    bool clearCustomDateRange = false,
    String? categoryFilter,
    bool clearCategoryFilter = false,
    TransactionSortOption? sortOption,
  }) {
    return TransactionHistoryFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      typeFilter: typeFilter ?? this.typeFilter,
      dateFilter: dateFilter ?? this.dateFilter,
      customDateRange: clearCustomDateRange
          ? null
          : (customDateRange ?? this.customDateRange),
      categoryFilter: clearCategoryFilter
          ? null
          : (categoryFilter ?? this.categoryFilter),
      sortOption: sortOption ?? this.sortOption,
    );
  }

  static const initial = TransactionHistoryFilter();
}
