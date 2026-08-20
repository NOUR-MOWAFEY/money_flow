import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/budget/view_models/budget_cubit/budget_cubit.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';
import 'package:money_flow/features/reports/views/widgets/category_budget_limits.dart';
import 'package:money_flow/features/reports/views/widgets/reports_failure_body.dart';
import 'package:money_flow/features/reports/views/widgets/reports_loading_body.dart';

class ReportsViewBudgetSection extends StatelessWidget {
  const ReportsViewBudgetSection({super.key, required this.selectedPeriod});

  final ReportPeriod selectedPeriod;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetCubit, BudgetState>(
      builder: (context, budgetState) {
        final isDaily = selectedPeriod == ReportPeriod.daily;

        if (budgetState is BudgetSuccess) {
          return CategoryBudgetLimits(items: isDaily ? [] : budgetState.items);
        } else if (budgetState is BudgetFailure) {
          return ReportsFailureBody(message: budgetState.message);
        }
        return const ReportsLoadingBody();
      },
    );
  }
}
