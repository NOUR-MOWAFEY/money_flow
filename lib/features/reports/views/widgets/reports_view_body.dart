import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/reports/view_models/reports_cubit/reports_cubit.dart';
import 'package:money_flow/features/reports/views/widgets/category_budget_limits.dart';
import 'package:money_flow/features/reports/views/widgets/reports_animated_toggle.dart';
import 'package:money_flow/features/reports/views/widgets/reports_bar_chart.dart';
import 'package:money_flow/features/reports/views/widgets/reports_failure_body.dart';
import 'package:money_flow/features/reports/views/widgets/reports_loading_body.dart';
import 'package:money_flow/features/reports/views/widgets/reports_pie_chart.dart';

class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final cubit = context.read<ReportsCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
          ),
          child: ListView(
            children: [
              const SizedBox(height: AppDimensions.viewTopSpace),

              const CustomText(
                'Reports',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              Center(
                child: ReportsAnimatedToggle(
                  selectedPeriod: cubit.selectedPeriod,
                  onChange: cubit.changePeriod,
                ),
              ),

              const SizedBox(height: 24),

              if (state is ReportsSuccess) ...[
                ReportsPieChart(items: state.pieItems),

                const SizedBox(height: 20),

                ReportsBarChart(data: state.barData),

                const SizedBox(height: 20),

                const CategoryBudgetLimits(),
              ] else if (state is ReportsFailure)
                ReportsFailureBody(message: state.message)
              else
                const ReportsLoadingBody(),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
