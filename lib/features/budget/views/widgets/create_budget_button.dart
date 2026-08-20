import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/budget/view_models/new_budget_cubit/new_budget_cubit.dart';

class CreateBudgetButton extends StatelessWidget {
  const CreateBudgetButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewBudgetCubit, NewBudgetState>(
      builder: (context, state) {
        return state is NewBudgetLoading
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 20, right: 20),
                child: CustomButton(
                  title: 'Create',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<NewBudgetCubit>().saveBudget();
                    }
                  },
                ),
              );
      },
    );
  }
}
