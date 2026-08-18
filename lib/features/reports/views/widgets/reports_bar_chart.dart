import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/reports/data/models/income_expense_bar_data.dart';
import 'package:money_flow/features/reports/views/widgets/reports_card.dart';

class ReportsBarChart extends StatefulWidget {
  const ReportsBarChart({super.key, this.data});

  final List<IncomeExpenseBarData>? data;

  static const Color incomeColor = Color(0xFF4E9F3D);
  static const Color expenseColor = AppColors.primary;

  @override
  State<ReportsBarChart> createState() => _ReportsBarChartState();
}

class _ReportsBarChartState extends State<ReportsBarChart> {
  int touchedGroupIndex = -1;

  List<IncomeExpenseBarData> get _defaultData => const [
    IncomeExpenseBarData(label: 'Mon', income: 320, expense: 210),
    IncomeExpenseBarData(label: 'Tue', income: 450, expense: 380),
    IncomeExpenseBarData(label: 'Wed', income: 280, expense: 190),
    IncomeExpenseBarData(label: 'Thu', income: 600, expense: 420),
    IncomeExpenseBarData(label: 'Fri', income: 520, expense: 490),
    IncomeExpenseBarData(label: 'Sat', income: 750, expense: 620),
    IncomeExpenseBarData(label: 'Sun', income: 410, expense: 300),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = (widget.data != null && widget.data!.isNotEmpty)
        ? widget.data!
        : _defaultData;

    final double maxVal = chartData.fold<double>(
      0,
      (prev, e) => max(prev, max(e.income, e.expense)),
    );
    final double maxY = (maxVal * 1.25).ceilToDouble();

    return ReportsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Income & Expenses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 6),

          _BarChartLegend(),

          const SizedBox(height: 24),

          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                barTouchData: _buildTouchData(chartData),
                titlesData: _buildTitlesData(chartData),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (maxY / 4).clamp(50, 1000).toDouble(),
                  getDrawingHorizontalLine: (_) => const FlLine(
                    color: Colors.white10,
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                alignment: BarChartAlignment.spaceAround,
                barGroups: _buildBarGroups(chartData),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarTouchData _buildTouchData(List<IncomeExpenseBarData> chartData) {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => AppColors.bg,
        tooltipMargin: 8,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        getTooltipItem: (group, _, rod, rodIndex) {
          final item = chartData[group.x];
          final isIncome = rodIndex == 0;
          final title = isIncome ? 'Income' : 'Expense';
          final value = isIncome ? item.income : item.expense;
          final color = isIncome
              ? ReportsBarChart.incomeColor
              : ReportsBarChart.expenseColor;

          return BarTooltipItem(
            '${item.label}\n',
            const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '$title: \$${value.toStringAsFixed(0)}',
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
      touchCallback: (event, response) {
        setState(() {
          touchedGroupIndex = response?.spot?.touchedBarGroupIndex ?? -1;
        });
      },
    );
  }

  FlTitlesData _buildTitlesData(List<IncomeExpenseBarData> chartData) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= chartData.length) {
              return const SizedBox.shrink();
            }
            final isTouched = index == touchedGroupIndex;
            return SideTitleWidget(
              meta: meta,
              space: 8,
              child: CustomText(
                chartData[index].label,
                style: TextStyle(
                  color: isTouched ? Colors.white : Colors.white60,
                  fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
    List<IncomeExpenseBarData> chartData,
  ) {
    return List.generate(chartData.length, (index) {
      final item = chartData[index];
      final isTouched = index == touchedGroupIndex;

      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: item.income,
            color: isTouched
                ? ReportsBarChart.incomeColor.withValues(alpha: 0.8)
                : ReportsBarChart.incomeColor,
            width: 10,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
          BarChartRodData(
            toY: item.expense,
            color: isTouched
                ? ReportsBarChart.expenseColor.withValues(alpha: 0.8)
                : ReportsBarChart.expenseColor,
            width: 10,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    });
  }
}

class _BarChartLegend extends StatelessWidget {
  const _BarChartLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _LegendItem(color: ReportsBarChart.incomeColor, label: 'Income'),
        SizedBox(width: 12),
        _LegendItem(color: ReportsBarChart.expenseColor, label: 'Expense'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        CustomText(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
