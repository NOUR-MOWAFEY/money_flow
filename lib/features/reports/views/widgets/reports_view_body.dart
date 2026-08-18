import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';
import 'package:money_flow/features/reports/views/widgets/category_budget_limits.dart';
import 'package:money_flow/features/reports/views/widgets/reports_animated_toggle.dart';
import 'package:money_flow/features/reports/views/widgets/reports_bar_chart.dart';
import 'package:money_flow/features/reports/views/widgets/reports_pie_chart.dart';

class ReportsViewBody extends StatefulWidget {
  const ReportsViewBody({super.key});

  @override
  State<ReportsViewBody> createState() => _ReportsViewBodyState();
}

class _ReportsViewBodyState extends State<ReportsViewBody> {
  ReportPeriod selectedPeriod = ReportPeriod.week;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child: ListView(
        children: [
          // Top Space
          const SizedBox(height: AppDimensions.viewTopSpace),

          // title
          const CustomText(
            'Reports',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          // Toggle Switch
          Center(
            child: ReportsAnimatedToggle(
              initialPeriod: selectedPeriod,
              onChange: (period) {
                setState(() {
                  selectedPeriod = period;
                });
              },
            ),
          ),

          const SizedBox(height: 24),

          // Pie Chart
          const ReportsPieChart(),

          const SizedBox(height: 20),

          // Bar Chart
          const ReportsBarChart(),

          const SizedBox(height: 20),

          // Category Limits Progress Bars
          const CategoryBudgetLimits(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
