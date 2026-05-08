import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/widgets/category_item.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({
    super.key,
    required this.transactionType,
    required this.category,
  });
  final TransactionType transactionType;
  final ValueNotifier<CategoryModel> category;

  @override
  Widget build(BuildContext context) {
    final isExpenses = transactionType == TransactionType.expenses;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 1,
          maxCrossAxisExtent: 100,
        ),

        itemCount: isExpenses
            ? AppCategories.expenseCategories.length
            : AppCategories.incomeCategories.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            category.value = isExpenses
                ? AppCategories.expenseCategories[index]
                : AppCategories.incomeCategories[index];

            Navigator.pop(context);
          },
          child: CategoryItem(
            category: isExpenses
                ? AppCategories.expenseCategories[index]
                : AppCategories.incomeCategories[index],
          ),
        ),
      ),
    );
  }
}
