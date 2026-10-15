import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/environment_balance_header.dart';
import 'package:money_flow/features/environments/views/widgets/environment_details_actions_row.dart';
import 'package:money_flow/features/environments/views/widgets/environment_expenses_empty_state.dart';
import 'package:money_flow/features/environments/views/widgets/environment_expenses_header.dart';
import 'package:money_flow/features/environments/views/widgets/environment_expenses_list.dart';

class EnvironmentDetailsSuccessBody extends StatelessWidget {
  const EnvironmentDetailsSuccessBody({
    super.key,
    required this.environment,
    required this.totalSpent,
    required this.expenses,
    required this.onAddFunds,
    required this.onSettle,
    required this.onDelete,
  });

  final EnvironmentModel environment;
  final double totalSpent;
  final List<EnvironmentExpenseModel> expenses;
  final VoidCallback? onAddFunds;
  final VoidCallback onSettle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
        vertical: 16,
      ),
      children: [
        EnvironmentBalanceHeader(
          environment: environment,
          totalSpent: totalSpent,
          onAddFunds: onAddFunds,
        ),
        const SizedBox(height: 16),
        EnvironmentDetailsActionsRow(
          isClosed: environment.isClosed,
          onSettle: onSettle,
          onDelete: onDelete,
        ),
        const SizedBox(height: 20),
        EnvironmentExpensesHeader(count: expenses.length),
        const SizedBox(height: 12),
        if (expenses.isEmpty)
          const EnvironmentExpensesEmptyState()
        else
          EnvironmentExpensesList(
            environment: environment,
            expenses: expenses,
          ),
        const SizedBox(height: 80),
      ],
    );
  }
}
