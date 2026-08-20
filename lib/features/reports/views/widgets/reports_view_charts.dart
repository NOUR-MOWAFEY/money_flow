import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/reports/view_models/reports_cubit/reports_cubit.dart';
import 'package:money_flow/features/reports/views/widgets/reports_bar_chart.dart';
import 'package:money_flow/features/reports/views/widgets/reports_failure_body.dart';
import 'package:money_flow/features/reports/views/widgets/reports_loading_body.dart';
import 'package:money_flow/features/reports/views/widgets/reports_pie_chart.dart';

class ReportsViewCharts extends StatelessWidget {
  const ReportsViewCharts({super.key, required this.state});

  final ReportsState state;

  @override
  Widget build(BuildContext context) {
    if (state is ReportsSuccess) {
      final successState = state as ReportsSuccess;
      return Column(
        children: [
          ReportsPieChart(items: successState.pieItems),
          const SizedBox(height: AppDimensions.chartSpacing),
          ReportsBarChart(data: successState.barData),
          const SizedBox(height: AppDimensions.chartSpacing),
        ],
      );
    } else if (state is ReportsFailure) {
      return ReportsFailureBody(message: (state as ReportsFailure).message);
    }
    return const ReportsLoadingBody();
  }
}
