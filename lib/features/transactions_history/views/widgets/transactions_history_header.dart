import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class TransactionsHistoryHeader extends StatelessWidget {
  const TransactionsHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: canPop ? AppDimensions.topSpace : AppDimensions.mainViewsTopSpace,
        ),
        if (canPop)
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomBackButton(),
          ),
        const CustomText(
          'Transactions History',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const CustomText(
          'Search, filter, and review all your transactions',
          style: TextStyle(fontSize: 13, color: Colors.white54),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
