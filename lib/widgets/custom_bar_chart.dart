import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/transaction_model.dart';

class CustomBarChart extends StatefulWidget {
  const CustomBarChart({
    super.key,
    required this.values,
    required this.expenses,
    required this.title,
  });
  final String title;

  static const Duration animDuration = Duration(milliseconds: 250);

  static const Color barColor = AppColors.primaryColor;
  static const Color touchedBarColor = AppColors.grey;
  static const Color barBackgroundColor =
      AppColors.secondaryColorWithHeightOpacity;

  final List<double> values;
  final List<TransactionModel> expenses;

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  int touchedIndex = -1;
  late double maxValue;

  @override
  Widget build(BuildContext context) {
    if (widget.values.isEmpty) {
      return const SizedBox.shrink();
    }
    maxValue = widget.values.reduce(max);

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Title(widget.title),
            SizedBox(height: 12),
            Expanded(child: _chart()),
          ],
        ),
      ),
    );
  }

  Widget _chart() {
    return BarChart(_barChartData(), duration: CustomBarChart.animDuration);
  }

  BarChartData _barChartData() {
    return BarChartData(
      barTouchData: _barTouchData(),
      titlesData: _titlesData(),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: _barGroups(),
    );
  }

  // touched data
  BarTouchData _barTouchData() {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => AppColors.grey,
        tooltipMargin: 5,
        getTooltipItem: (group, _, rod, _) {
          String date = DateFormat.yMMMd().format(
            widget.expenses[group.x].date,
          );
          return BarTooltipItem(
            '$date\n',
            const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: (rod.toY - maxValue / 10).toStringAsFixed(1),
                style: const TextStyle(color: AppColors.white, fontSize: 16),
              ),
            ],
          );
        },
      ),
      touchCallback: (event, response) {
        setState(() {
          touchedIndex = response?.spot?.touchedBarGroupIndex ?? -1;
        });
      },
    );
  }

  List<BarChartGroupData> _barGroups() {
    return List.generate(
      widget.values.length,
      (index) => _makeGroupData(
        x: index,
        y: widget.values[index],
        isTouched: index == touchedIndex,
      ),
    );
  }

  // touched bar change
  BarChartGroupData _makeGroupData({
    required int x,
    required double y,
    required bool isTouched,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + maxValue / 10 : y,
          width: 22,
          color: isTouched
              ? CustomBarChart.touchedBarColor
              : CustomBarChart.barColor,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxValue + 50,
            color: CustomBarChart.barBackgroundColor,
          ),
        ),
      ],
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 38,
          getTitlesWidget: _bottomTitle,
        ),
      ),
    );
  }

  Widget _bottomTitle(double value, TitleMeta meta) {
    if (value.toInt() >= 0 && value.toInt() < widget.expenses.length) {
      String date = DateFormat.Md().format(widget.expenses[value.toInt()].date);
      return SideTitleWidget(
        meta: meta,
        space: 16,
        child: Text(
          date,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }
    return SideTitleWidget(meta: meta, space: 16, child: const Text(''));
  }
}

// top title
class _Title extends StatelessWidget {
  const _Title(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
