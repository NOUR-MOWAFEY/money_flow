import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/models/transaction_model.dart';

class HiveService {
  static const String _boxName = 'transactions';

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
}
