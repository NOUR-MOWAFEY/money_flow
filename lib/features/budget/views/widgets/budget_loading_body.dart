import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class BudgetLoadingBody extends StatelessWidget {
  const BudgetLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 280,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.loadingIndicator),
      ),
    );
  }
}
