// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/widgets.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class BackupDataSerializer {
  const BackupDataSerializer._();

  static Map<String, dynamic> transactionToJson(TransactionModel transaction) {
    return {
      'id': transaction.id,
      'title': transaction.title,
      'amount': transaction.amount,
      'date': transaction.date.toIso8601String(),
      'isExpense': transaction.isExpense,
    };
  }

  static TransactionModel transactionFromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      isExpense: json['isExpense'] as bool,
    );
  }

  static Map<String, dynamic> categoryToJson(CategoryModel category) {
    return {
      'title': category.title,
      'iconCodePoint': category.icon.codePoint,
      'iconFontFamily': category.icon.fontFamily,
      'iconFontPackage': category.icon.fontPackage,
      'color': category.color.toARGB32(),
      'categoryType': category.categoryType.name,
    };
  }

  static CategoryModel categoryFromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'] as String,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: json['iconFontFamily'] as String?,
        fontPackage: json['iconFontPackage'] as String?,
      ),
      color: Color(json['color'] as int),
      categoryType: CategoryType.values.byName(json['categoryType'] as String),
    );
  }

  static Map<String, dynamic> budgetToJson(BudgetModel budget) {
    return {
      'categoryTitle': budget.categoryTitle,
      'limitAmount': budget.limitAmount,
      'period': budget.period.name,
    };
  }

  static BudgetModel budgetFromJson(Map<String, dynamic> json) {
    return BudgetModel(
      categoryTitle: json['categoryTitle'] as String,
      limitAmount: (json['limitAmount'] as num).toDouble(),
      period: BudgetPeriod.values.byName(json['period'] as String),
    );
  }

  static Map<String, dynamic> recurringToJson(
    RecurringTransactionModel recurring,
  ) {
    return {
      'id': recurring.id,
      'title': recurring.title,
      'amount': recurring.amount,
      'type': recurring.type.name,
      'frequency': recurring.frequency.name,
      'startDate': recurring.startDate.toIso8601String(),
      'endDate': recurring.endDate?.toIso8601String(),
      'isActive': recurring.isActive,
      'categoryTitle': recurring.categoryTitle,
      'nextOccurrence': recurring.nextOccurrence?.toIso8601String(),
      'note': recurring.note,
    };
  }

  static RecurringTransactionModel recurringFromJson(
    Map<String, dynamic> json,
  ) {
    return RecurringTransactionModel(
      id: (json['id'] as String?) ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: CategoryType.values.byName(json['type'] as String),
      frequency: RecurrenceFrequency.values.byName(json['frequency'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      isActive: (json['isActive'] as bool?) ?? true,
      categoryTitle: json['categoryTitle'] as String?,
      nextOccurrence: json['nextOccurrence'] != null
          ? DateTime.parse(json['nextOccurrence'] as String)
          : null,
      note: json['note'] as String?,
    );
  }

  static Map<String, dynamic> userToJson(UserModel user) {
    return user.toJson();
  }

  static UserModel userFromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
