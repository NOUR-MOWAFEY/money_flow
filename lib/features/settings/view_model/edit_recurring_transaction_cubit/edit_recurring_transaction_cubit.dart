import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_data_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';

part 'edit_recurring_transaction_state.dart';

class EditRecurringTransactionCubit extends Cubit<EditRecurringTransactionState> {
  EditRecurringTransactionCubit(this.recurringTransaction, this.hiveService)
      : dataModel = RecurringTransactionDataModel.fromModel(
          recurringTransaction,
          hiveService,
        ),
        super(EditRecurringTransactionInitial());

  final RecurringTransactionModel recurringTransaction;
  final HiveService hiveService;
  final RecurringTransactionDataModel dataModel;

  String? validate() {
    final amount = double.tryParse(dataModel.amountController.text.trim());
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }

    if (dataModel.category.value == null) {
      return 'Please select a category';
    }

    if (dataModel.endDate.value != null &&
        dataModel.endDate.value!.isBefore(dataModel.startDate.value)) {
      return 'End date cannot be before start date';
    }

    return null;
  }

  Future<void> updateRecurringTransaction() async {
    final error = validate();
    if (error != null) {
      emit(EditRecurringTransactionFailure(error));
      emit(EditRecurringTransactionInitial());
      return;
    }

    emit(EditRecurringTransactionLoading());

    try {
      final categoryTitle = dataModel.category.value!.title;
      await hiveService.updateRecurringTransaction(
        recurringTransaction,
        title: categoryTitle,
        amount: double.parse(dataModel.amountController.text.trim()),
        type: dataModel.type.value,
        categoryTitle: categoryTitle,
        frequency: dataModel.frequency.value,
        startDate: dataModel.startDate.value,
        endDate: dataModel.endDate.value,
      );
      emit(EditRecurringTransactionSuccess());
    } catch (_) {
      emit(EditRecurringTransactionFailure(
        'Failed to update recurring transaction, Please try again',
      ));
      emit(EditRecurringTransactionInitial());
    }
  }

  Future<void> deleteRecurringTransaction() async {
    emit(EditRecurringTransactionLoading());

    try {
      await hiveService.deleteRecurringTransaction(recurringTransaction);
      emit(EditRecurringTransactionSuccess());
    } catch (_) {
      emit(EditRecurringTransactionFailure(
        'Failed to delete recurring transaction, Please try again',
      ));
      emit(EditRecurringTransactionInitial());
    }
  }

  @override
  Future<void> close() {
    dataModel.dispose();
    return super.close();
  }
}
