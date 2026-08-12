import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/core/utils/date_formatter.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_slidable.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile_price.dart';

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
    final CategoryModel category = getCategory(
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
          minTileHeight: 65,
          // icon
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: category.color,
            foregroundColor: AppColors.icon,
            child: Icon(category.icon),
          ),

          // title
          title: CustomText(
            transactionModel.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          // date
          subtitle: CustomText(
            DateFormatter.dateFormatter(transactionModel.date),
            style: const TextStyle(fontSize: 14),
          ),

          // amount
          trailing: TransactionTilePrice(transactionModel: transactionModel),
        ),
      ),
    );
  }
}
