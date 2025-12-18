import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/transaction_model.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart({
    super.key,
    required this.values,
    required this.expenses,
    required this.title,
  });

  static const Color lineColor = AppColors.primaryColor;
  static const Color pointColor = AppColors.secondaryColor;
  final String title;

  final List<double> values;
  final List<TransactionModel> expenses;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  late double maxValue;
  late double minValue;

  @override
  Widget build(BuildContext context) {
    if (widget.values.isEmpty) {
      return const SizedBox.shrink();
    }
    maxValue = widget.values.reduce(max);
    minValue = widget.values.reduce(min);

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Title(widget.title),
            const SizedBox(height: 12),
            Expanded(child: _chart()),
          ],
        ),
      ),
    );
  }

  Widget _chart() {
    return LineChart(
      _lineChartData(),
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData _lineChartData() {
    return LineChartData(
      lineTouchData: _lineTouchData(),
      titlesData: _titlesData(),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: _generateSpots(),
          isCurved: true,
          color: CustomLineChart.lineColor,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            color: const Color.fromARGB(59, 125, 140, 134),
          ),
        ),
      ],
      minY: 0,
    );
  }

  // touched data
  LineTouchData _lineTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (_) => AppColors.grey,
        tooltipMargin: 5,
        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
          return touchedBarSpots.map((barSpot) {
            String date = DateFormat.yMMMd().format(
              widget.expenses[barSpot.x.toInt()].date,
            );
            return LineTooltipItem(
              '$date\n',
              const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: barSpot.y.toStringAsFixed(1),
                  style: const TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ],
            );
          }).toList();
        },
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    return List.generate(
      widget.values.length,
      (index) => FlSpot(index.toDouble(), widget.values[index]),
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
          interval: 1,
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
      padding: const EdgeInsets.only(bottom: 16),
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
