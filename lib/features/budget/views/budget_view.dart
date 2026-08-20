import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/budget/view_models/budget_cubit/budget_cubit.dart';
import 'package:money_flow/features/budget/views/add_budget_view.dart';
import 'package:money_flow/features/budget/views/widgets/budget_view_body.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_floating_action_button.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BudgetCubit(HiveService())..loadBudgets(),
      child: const Scaffold(
        floatingActionButton: CustomFloatingActionButton(view: AddBudgetView()),
        body: SafeArea(child: BudgetViewBody()),
      ),
    );
  }
}
