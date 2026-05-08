import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/widgets/category_item.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key, required this.transactionType});
  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 1,
          maxCrossAxisExtent: 100,
        ),

        itemCount: 12,
        itemBuilder: (BuildContext context, int index) => CategoryItem(
          category: transactionType == TransactionType.expenses
              ? AppCategories.expenseCategories[index]
              : AppCategories.incomeCategories[index],
        ),
      ),
    );
  }
}
