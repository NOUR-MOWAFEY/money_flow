import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ReportsViewHeader extends StatelessWidget {
  const ReportsViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomText(
      'Reports',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}
