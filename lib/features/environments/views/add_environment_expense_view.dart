import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/add_environment_expense_view_body.dart';

class AddEnvironmentExpenseView extends StatelessWidget {
  const AddEnvironmentExpenseView({
    super.key,
    required this.environment,
  });

  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Add Expense'),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: AddEnvironmentExpenseViewBody(environment: environment),
      ),
    );
  }
}
