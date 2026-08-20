import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

part 'edit_budget_state.dart';

class EditBudgetCubit extends Cubit<EditBudgetState> {
  EditBudgetCubit(this.budget, this.hiveService) : super(EditBudgetInitial()) {
    amountController.text = budget.limitAmount.toStringAsFixed(0);
    selectedCategory = getCategory(budget.categoryTitle, true, hiveService);
    selectedPeriod = budget.period;
  }

  final BudgetModel budget;
  final HiveService hiveService;
  final TextEditingController amountController = TextEditingController();

  late CategoryModel selectedCategory;
  late BudgetPeriod selectedPeriod;

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    emit(EditBudgetInitial());
  }

  void selectPeriod(BudgetPeriod period) {
    selectedPeriod = period;
    emit(EditBudgetInitial());
  }

  String? validate() {
    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount <= 0) {
      return 'Please enter a valid limit amount';
    }

    final hasDuplicate = hiveService.getBudgets().any(
      (existingBudget) =>
          existingBudget.key != budget.key &&
          existingBudget.categoryTitle == selectedCategory.title,
    );

    if (hasDuplicate) {
      return 'A budget already exists for this category';
    }

    return null;
  }

  Future<void> updateBudget() async {
    final error = validate();
    if (error != null) {
      emit(EditBudgetFailure(error));
      emit(EditBudgetInitial());
      return;
    }

    emit(EditBudgetLoading());

    try {
      await hiveService.updateBudget(
        budget,
        categoryTitle: selectedCategory.title,
        limitAmount: double.parse(amountController.text.trim()),
        period: selectedPeriod,
      );
      emit(EditBudgetSuccess());
    } catch (_) {
      emit(EditBudgetFailure('Failed to update budget, Please try again'));
      emit(EditBudgetInitial());
    }
  }

  Future<void> deleteBudget() async {
    emit(EditBudgetLoading());

    try {
      await hiveService.deleteBudget(budget);
      emit(EditBudgetSuccess());
    } catch (_) {
      emit(EditBudgetFailure('Failed to delete budget, Please try again'));
      emit(EditBudgetInitial());
    }
  }

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }
}
