import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/edit_environment_expense_view_body.dart';

class EditEnvironmentExpenseView extends StatelessWidget {
  const EditEnvironmentExpenseView({
    super.key,
    required this.environment,
    required this.expense,
  });

  final EnvironmentModel environment;
  final EnvironmentExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Edit Expense'),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditEnvironmentExpenseViewBody(
          environment: environment,
          expense: expense,
        ),
      ),
    );
  }
}
