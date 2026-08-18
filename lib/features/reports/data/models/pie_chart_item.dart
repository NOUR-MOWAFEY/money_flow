import 'package:flutter/material.dart';

class PieChartItem {
  const PieChartItem({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final double value;
  final Color color;
}
