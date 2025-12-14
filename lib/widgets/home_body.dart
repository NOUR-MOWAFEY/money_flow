import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/widgets/custom_app_bar.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              const CustomAppBar(),
              const SizedBox(height: 24),
              const Text(
                'Available Balance',
                style: TextStyle(fontSize: 16, color: AppColors.white),
              ),
              const Text(
                'EGP 5100.50',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => TransactionTile(
                    isLastOne: index == 9 ? true : false,
                    icon: AppCategories.expenseCategories.values
                        .toList()[index],
                    title: AppCategories.expenseCategories.keys.toList()[index],
                  ),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
