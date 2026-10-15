import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/edit_transaction_view.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_slidable.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile_price.dart';

import 'package:money_flow/features/transactions/views/widgets/linked_transaction_dialog.dart';

class TransactionsHistoryTile extends StatelessWidget {
  const TransactionsHistoryTile({
    super.key,
    required this.transactionModel,
    required this.category,
  });

  final TransactionModel transactionModel;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CustomSlidable(
        transactionModel: transactionModel,
        child: InkWell(
          onTap: () {
            if (transactionModel.isEnvironmentActive()) {
              showLinkedTransactionDialog(context, transactionModel);
              return;
            }
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) =>
                    EditTransactionView(transactionModel: transactionModel),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            minVerticalPadding: 6,
            minTileHeight: 60,
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: category.color.categoryContainerColor,
              child: Icon(
                category.icon,
                color: category.color.categoryIconColor,
                size: 20,
              ),
            ),
            title: CustomText(
              transactionModel.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  DateFormat('hh:mm a').format(transactionModel.date),
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
                if (transactionModel.isEnvironmentActive()) ...[
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.lock_outline_rounded,
                    size: 13,
                    color: Colors.white38,
                  ),
                ],
              ],
            ),
            trailing: TransactionTilePrice(transactionModel: transactionModel),
          ),
        ),
      ),
    );
  }
}
