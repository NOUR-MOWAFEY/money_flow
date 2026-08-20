import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/view_models/budget_cubit/budget_cubit.dart';
import 'package:money_flow/features/budget/views/widgets/budget_failure_body.dart';
import 'package:money_flow/features/budget/views/widgets/budget_loading_body.dart';
import 'package:money_flow/features/budget/views/widgets/budget_success_body.dart';

class BudgetViewBody extends StatelessWidget {
  const BudgetViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetCubit, BudgetState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
          ),
          child: ListView(
            children: [
              const SizedBox(height: AppDimensions.viewTopSpace),

              const CustomText(
                'Budget',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const CustomText(
                'Set spending limits and track your progress',
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),

              const SizedBox(height: 24),

              if (state is BudgetSuccess)
                BudgetSuccessBody(items: state.items)
              else if (state is BudgetFailure)
                BudgetFailureBody(message: state.message)
              else
                const BudgetLoadingBody(),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
