import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class TransactionsHistoryLoadingBody extends StatelessWidget {
  const TransactionsHistoryLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
