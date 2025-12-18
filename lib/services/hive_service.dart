import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/models/transaction_model.dart';

class HiveService {
  static const String _boxName = 'transactions';
  static const String _userBoxName = 'user';

  static Box get _userBox {
    return Hive.box(_userBoxName);
  }

  static bool get isFirstTime {
    return _userBox.get('isFirstTime', defaultValue: true);
  }

  static Future<void> setNotFirstTime() async {
    await _userBox.put('isFirstTime', false);
  }

  static Future<void> saveUser(String name, String image) async {
    await _userBox.put('name', name);
    await _userBox.put('image', image);
  }

  static String get userName {
    return _userBox.get('name', defaultValue: '');
  }

  static String get userImage {
    return _userBox.get('image', defaultValue: '');
  }

  Box<TransactionModel> get _box {
    return Hive.box<TransactionModel>(_boxName);
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _box.add(transaction);
  }

  Future<void> deleteTransaction(int index) async {
    await _box.deleteAt(index);
  }

  List<TransactionModel> getTransactions() {
    return _box.values.toList().reversed.toList();
  }

  ValueListenable<Box<TransactionModel>> get listenable {
    return _box.listenable();
  }

  Future<void> reset() async {
    await _box.clear();
  }

  bool isEmpty() {
    return _box.isEmpty;
  }

  static List<TransactionModel> getExpenses(
    List<TransactionModel> transactions,
  ) {
    List<TransactionModel> expenses = [];
    for (var transaction in transactions) {
      if (transaction.isExpense) {
        expenses.add(transaction);
      }
    }
    return expenses;
  }

  static List<TransactionModel> getIncome(List<TransactionModel> transactions) {
    List<TransactionModel> income = [];
    for (var transaction in transactions) {
      if (!transaction.isExpense) {
        income.add(transaction);
      }
    }
    return income;
  }

  static List<double> getAmounts(List<TransactionModel> transactions) {
    List<double> amounts = [];
    for (var element in transactions) {
      amounts.add(element.amount.abs());
    }
    return amounts;
  }

  static List<String> getFormatedDate(List<TransactionModel> expenses) {
    List<String> date = [];
    for (var element in expenses) {
      date.add(DateFormat.Md().format(element.date).toString());
    }
    return date;
  }
}
