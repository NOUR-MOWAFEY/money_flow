import 'package:flutter/material.dart';
import 'package:money_flow/features/budget/views/widgets/delete_budget_button.dart';
import 'package:money_flow/features/budget/views/widgets/edit_budget_button.dart';

class EditBudgetViewButtons extends StatelessWidget {
  const EditBudgetViewButtons({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, left: 20, right: 20),
      child: Row(
        children: [
          const Expanded(child: DeleteBudgetButton()),
          const SizedBox(width: 12),
          Expanded(child: EditBudgetButton(formKey: formKey)),
        ],
      ),
    );
  }
}
