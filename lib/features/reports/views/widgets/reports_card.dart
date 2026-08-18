import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class ReportsCard extends StatelessWidget {
  const ReportsCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
