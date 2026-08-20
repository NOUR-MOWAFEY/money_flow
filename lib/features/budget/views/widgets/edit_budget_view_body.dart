import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/view_models/edit_budget_cubit/edit_budget_cubit.dart';
import 'package:money_flow/features/budget/views/widgets/budget_category_field.dart';
import 'package:money_flow/features/budget/views/widgets/budget_period_toggle.dart';
import 'package:money_flow/features/transactions/views/widgets/amount_field.dart';

class EditBudgetViewBody extends StatelessWidget {
  const EditBudgetViewBody({super.key, required this.budget});

  final BudgetModel budget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<EditBudgetCubit, EditBudgetState>(
        listener: (context, state) {
          if (state is EditBudgetSuccess) {
            ShowToastification.success(context, 'Budget updated successfully');
            Navigator.pop(context);
          } else if (state is EditBudgetFailure) {
            ShowToastification.failure(context, state.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<EditBudgetCubit>();

          if (state is EditBudgetLoading) {
            return const CustomLoading();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditBudgetPeriodSwitch(cubit: cubit),

              const SizedBox(height: 24),

              EditBudgetAmountField(cubit: cubit),

              const SizedBox(height: 24),

              EditBudgetCategoryField(cubit: cubit),
            ],
          );
        },
      ),
    );
  }
}

class EditBudgetPeriodSwitch extends StatelessWidget {
  const EditBudgetPeriodSwitch({super.key, required this.cubit});

  final EditBudgetCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const CustomText(
          'Period',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),

        const SizedBox(height: 12),

        Center(
          child: BudgetPeriodToggle(
            selectedPeriod: cubit.selectedPeriod,
            onChange: cubit.selectPeriod,
          ),
        ),
      ],
    );
  }
}

class EditBudgetAmountField extends StatelessWidget {
  const EditBudgetAmountField({super.key, required this.cubit});

  final EditBudgetCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,

      children: [
        const CustomText(
          'Limit Amount',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),

        const SizedBox(height: 12),

        AmountField(amountController: cubit.amountController),
      ],
    );
  }
}

class EditBudgetCategoryField extends StatelessWidget {
  const EditBudgetCategoryField({super.key, required this.cubit});

  final EditBudgetCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,

      children: [
        const CustomText(
          'Category',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),

        const SizedBox(height: 12),

        BudgetCategoryField(
          category: cubit.selectedCategory,
          excludedTitles: HiveService()
              .getBudgets()
              .map((budget) => budget.categoryTitle)
              .toList(),
          onCategorySelected: cubit.selectCategory,
        ),
      ],
    );
  }
}
