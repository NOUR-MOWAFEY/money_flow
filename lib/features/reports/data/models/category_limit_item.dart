import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class CategoryLimitItem {
  const CategoryLimitItem({
    required this.title,
    required this.icon,
    required this.spent,
    required this.limit,
    this.iconColor,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
  final double spent;
  final double limit;

  double get ratio => limit > 0 ? (spent / limit) : 0.0;
  double get progress => ratio.clamp(0.0, 1.0);
  int get percentage => (ratio * 100).toInt();

  Color get statusColor {
    if (ratio >= 0.85) {
      return AppColors.error;
    } else if (ratio >= 0.60) {
      return const Color(0xFFE5A93C);
    } else {
      return const Color(0xFF4E9F3D);
    }
  }
}
