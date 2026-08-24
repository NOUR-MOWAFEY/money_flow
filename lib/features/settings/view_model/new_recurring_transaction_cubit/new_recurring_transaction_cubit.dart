import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/services/recurring_processor_service.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_data_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';

part 'new_recurring_transaction_state.dart';

class NewRecurringTransactionCubit extends Cubit<NewRecurringTransactionState> {
  NewRecurringTransactionCubit(this.hiveService)
      : dataModel = RecurringTransactionDataModel.initial(),
        super(NewRecurringTransactionInitial());

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

  Future<void> saveRecurringTransaction() async {
    final error = validate();
    if (error != null) {
      emit(NewRecurringTransactionFailure(error));
      emit(NewRecurringTransactionInitial());
      return;
    }

    emit(NewRecurringTransactionLoading());

    try {
      final categoryTitle = dataModel.category.value!.title;
      final model = RecurringTransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: categoryTitle,
        amount: double.parse(dataModel.amountController.text.trim()),
        type: dataModel.type.value,
        categoryTitle: categoryTitle,
        frequency: dataModel.frequency.value,
        startDate: dataModel.startDate.value,
        endDate: dataModel.endDate.value,
        isActive: true,
      );

      await hiveService.addRecurringTransaction(model);
      await RecurringProcessorService.instance
          .processDueRecurringTransactions(hiveService);
      emit(NewRecurringTransactionSuccess());
    } catch (_) {
      emit(NewRecurringTransactionFailure(
        'Failed to save recurring transaction, Please try again',
      ));
      emit(NewRecurringTransactionInitial());
    }
  }

  @override
  Future<void> close() {
    dataModel.dispose();
    return super.close();
  }
}
