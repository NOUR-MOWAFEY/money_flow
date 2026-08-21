import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/view_header.dart';
import 'package:money_flow/features/budget/view_models/budget_cubit/budget_cubit.dart';
import 'package:money_flow/features/reports/view_models/reports_cubit/reports_cubit.dart';
import 'package:money_flow/features/reports/views/widgets/reports_animated_toggle.dart';
import 'package:money_flow/features/reports/views/widgets/reports_view_budget_section.dart';
import 'package:money_flow/features/reports/views/widgets/reports_view_charts.dart';

class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final reportsCubit = context.read<ReportsCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
          ),
          child: ListView(
            children: [
              const ViewHeader(title: 'Reports'),

              Center(
                child: ReportsAnimatedToggle(
                  selectedPeriod: reportsCubit.selectedPeriod,
                  onChange: (period) {
                    reportsCubit.changePeriod(period);
                    context.read<BudgetCubit>().changePeriod(period);
                  },
                ),
              ),

              const SizedBox(height: 24),

              ReportsViewCharts(state: state),

              ReportsViewBudgetSection(
                selectedPeriod: reportsCubit.selectedPeriod,
              ),

              const SizedBox(height: AppDimensions.viewBottomSpace),
            ],
          ),
        );
      },
    );
  }
}
