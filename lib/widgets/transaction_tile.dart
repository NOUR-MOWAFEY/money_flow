import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/widgets/custom_slidable.dart';
import 'package:money_flow/widgets/transaction_tile_price.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transactionModel});

  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    final category = _getCategory(
      transactionModel.title,
      transactionModel.isExpense,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: CustomSlidable(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 8,
            minTileHeight: 70,
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: category.color,
              foregroundColor: AppColors.white,
              child: Icon(category.icon),
            ),

            title: Text(
              transactionModel.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            subtitle: Text(
              transactionModel.date,
              style: TextStyle(fontSize: 14),
            ),

            trailing: TransactionTilePrice(transactionModel: transactionModel),
          ),
        ),
      ),
    );
  }

  CategoryModel _getCategory(String title, bool isExpenses) {
    final list = isExpenses
        ? AppCategories.expenseCategories
        : AppCategories.incomeCategories;
    final category = list.firstWhere((element) => element.title == title);
    return category;
  }
}
