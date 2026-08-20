import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/budget/view_models/edit_budget_cubit/edit_budget_cubit.dart';
import 'package:money_flow/features/budget/views/widgets/edit_budget_view_body.dart';
import 'package:money_flow/features/budget/views/widgets/edit_budget_view_buttons.dart';

class EditBudgetView extends StatefulWidget {
  const EditBudgetView({super.key, required this.budget});

  final BudgetModel budget;

  @override
  State<EditBudgetView> createState() => _EditBudgetViewState();
}

class _EditBudgetViewState extends State<EditBudgetView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) => EditBudgetCubit(widget.budget, HiveService()),
          child: Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: const CustomText('Edit Budget'),
            ),
            body: EditBudgetViewBody(budget: widget.budget),
            bottomNavigationBar: EditBudgetViewButtons(formKey: formKey),
          ),
        ),
      ),
    );
  }
}
