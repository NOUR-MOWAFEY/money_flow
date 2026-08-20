import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/view_models/new_budget_cubit/new_budget_cubit.dart';
import 'package:money_flow/features/budget/views/widgets/add_budget_view_body.dart';
import 'package:money_flow/features/budget/views/widgets/create_budget_button.dart';

class AddBudgetView extends StatefulWidget {
  const AddBudgetView({super.key});

  @override
  State<AddBudgetView> createState() => _AddBudgetViewState();
}

class _AddBudgetViewState extends State<AddBudgetView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) => NewBudgetCubit(HiveService()),
          child: Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: const CustomText('Add Budget'),
            ),

            body: const AddBudgetViewBody(),

            bottomNavigationBar: CreateBudgetButton(formKey: formKey),
          ),
        ),
      ),
    );
  }
}
