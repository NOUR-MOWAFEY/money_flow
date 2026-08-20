import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/budget/view_models/edit_budget_cubit/edit_budget_cubit.dart';

class DeleteBudgetButton extends StatelessWidget {
  const DeleteBudgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBudgetCubit, EditBudgetState>(
      builder: (context, state) {
        return CustomButton(
          title: 'Delete',
          onTap: state is EditBudgetLoading
              ? null
              : () => context.read<EditBudgetCubit>().deleteBudget(),
        );
      },
    );
  }
}
