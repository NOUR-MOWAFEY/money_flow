import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/widgets/custom_slidable.dart';
import 'package:money_flow/widgets/transaction_tile_price.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transactionModel,
    required this.index,
  });

  final TransactionModel transactionModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final CategoryModel category = _getCategory(
      transactionModel.title,
      transactionModel.isExpense,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: CustomSlidable(
        transactionModel: transactionModel,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          minVerticalPadding: 8,
          minTileHeight: 70,
          // icon
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: category.color,
            foregroundColor: AppColors.white,
            child: Icon(category.icon),
          ),

          // title
          title: Text(
            transactionModel.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          // date
          subtitle: Text(
            transactionModel.date,
            style: const TextStyle(fontSize: 14),
          ),

          // amount
          trailing: TransactionTilePrice(transactionModel: transactionModel),
        ),
      ),
    );
  }

  CategoryModel _getCategory(String title, bool isExpenses) {
    final list = isExpenses
        ? AppCategories.expenseCategories
        : AppCategories.incomeCategories;
    final category = list.firstWhere(
      (element) => element.title == title,
      orElse: () => AppCategories.defaultCategory, // or some fallback
    );
    return category;
  }
}
