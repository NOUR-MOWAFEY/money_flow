import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/budget/view_models/edit_budget_cubit/edit_budget_cubit.dart';

class EditBudgetButton extends StatelessWidget {
  const EditBudgetButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBudgetCubit, EditBudgetState>(
      builder: (context, state) {
        return CustomButton(
          title: 'Save',
          onTap: state is EditBudgetLoading
              ? null
              : () async {
                  if (formKey.currentState!.validate()) {
                    await context.read<EditBudgetCubit>().updateBudget();
                  }
                },
        );
      },
    );
  }
}
