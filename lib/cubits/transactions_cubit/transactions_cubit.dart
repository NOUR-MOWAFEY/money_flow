import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/services/hive_service.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(this.hiveService) : super(TransactionsInitial());
  final HiveService hiveService;

  //get all transactions
  void getAllTransactions() {
    emit(TransactionsLoading());
    try {
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions));
    } catch (e) {
      emit(
        TransactionsFailure('Failed to load transactions, Please try again'),
      );
    }
  }

  // add transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    emit(TransactionsLoading());
    try {
      await hiveService.addTransaction(transaction);
      final transactions = hiveService.getTransactions();

      emit(TransactionsSuccess(transactions));
      log('Done');
      log(transactions.toString());
    } catch (e) {
      emit(TransactionsFailure('Failed to add transaction, Please try again'));
    }
  }

  //delete transaction
  Future<void> deleteTransaction(TransactionModel transaction) async {
    emit(TransactionsLoading());
    try {
      await hiveService.deleteTransaction(transaction);
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions));
    } catch (e) {
      emit(
        TransactionsFailure('Failed to delete transaction, Please try again'),
      );
    }
  }

  // clear transactions
  Future<void> clearTransactions() async {
    emit(TransactionsLoading());
    try {
      await hiveService.reset();
      final transactions = hiveService.getTransactions();
      emit(TransactionsSuccess(transactions));
    } catch (e) {
      emit(
        TransactionsFailure(
          'Failed to delete all transactions, Please try again',
        ),
      );
    }
  }
}
