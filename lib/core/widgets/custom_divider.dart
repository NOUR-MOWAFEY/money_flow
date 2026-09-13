import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 36,
      indent: 24,
      endIndent: 24,
      color: AppColors.divider,
    );
  }
}
