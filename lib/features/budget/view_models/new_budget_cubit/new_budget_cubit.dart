import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

part 'new_budget_state.dart';

class NewBudgetCubit extends Cubit<NewBudgetState> {
  NewBudgetCubit(this.hiveService) : super(NewBudgetInitial());

  final HiveService hiveService;
  final TextEditingController amountController = TextEditingController();

  CategoryModel? selectedCategory;
  BudgetPeriod selectedPeriod = BudgetPeriod.monthly;

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    emit(NewBudgetInitial());
  }

  void selectPeriod(BudgetPeriod period) {
    selectedPeriod = period;
    emit(NewBudgetInitial());
  }

  String? validate() {
    if (selectedCategory == null) {
      return 'Please select a category';
    }

    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount <= 0) {
      return 'Please enter a valid limit amount';
    }

    if (hiveService.hasBudgetForCategory(selectedCategory!.title)) {
      return 'A budget already exists for this category';
    }

    return null;
  }

  Future<void> saveBudget() async {
    final error = validate();
    if (error != null) {
      emit(NewBudgetFailure(error));
      emit(NewBudgetInitial());
      return;
    }

    emit(NewBudgetLoading());

    try {
      final budget = BudgetModel(
        categoryTitle: selectedCategory!.title,
        limitAmount: double.parse(amountController.text.trim()),
        period: selectedPeriod,
      );

      await hiveService.addBudget(budget);
      emit(NewBudgetSuccess());
    } catch (_) {
      emit(NewBudgetFailure('Failed to save budget, Please try again'));
      emit(NewBudgetInitial());
    }
  }

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }
}
