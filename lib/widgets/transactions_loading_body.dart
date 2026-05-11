import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class TransactionsLoadingBody extends StatelessWidget {
  const TransactionsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }
}
