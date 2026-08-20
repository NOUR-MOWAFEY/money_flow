import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/view_models/new_budget_cubit/new_budget_cubit.dart';
import 'package:money_flow/features/budget/views/widgets/budget_category_field.dart';
import 'package:money_flow/features/budget/views/widgets/budget_period_toggle.dart';
import 'package:money_flow/features/transactions/views/widgets/amount_field.dart';

class AddBudgetViewBody extends StatelessWidget {
  const AddBudgetViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<NewBudgetCubit, NewBudgetState>(
        listener: (context, state) {
          if (state is NewBudgetSuccess) {
            ShowToastification.success(context, 'Budget added successfully');
            Navigator.pop(context);
          } else if (state is NewBudgetFailure) {
            ShowToastification.failure(context, state.message);
          }
        },

        builder: (context, state) {
          final cubit = context.read<NewBudgetCubit>();

          if (state is NewBudgetLoading) {
            return const CustomLoading();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddBudgetPeriodSwitch(cubit: cubit),

              const SizedBox(height: 24),

              AddBudgetAmountField(cubit: cubit),

              const SizedBox(height: 24),

              AddBudgetCategoryField(cubit: cubit),
            ],
          );
        },
      ),
    );
  }
}

class AddBudgetPeriodSwitch extends StatelessWidget {
  const AddBudgetPeriodSwitch({super.key, required this.cubit});

  final NewBudgetCubit cubit;

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

class AddBudgetAmountField extends StatelessWidget {
  const AddBudgetAmountField({super.key, required this.cubit});

  final NewBudgetCubit cubit;

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

class AddBudgetCategoryField extends StatelessWidget {
  const AddBudgetCategoryField({super.key, required this.cubit});

  final NewBudgetCubit cubit;

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
