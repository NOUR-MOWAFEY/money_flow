import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 34,
      indent: 20,
      endIndent: 20,
      color: AppColors.divider,
    );
  }
}
