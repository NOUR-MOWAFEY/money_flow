import 'package:flutter/material.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/utils/date_formatter.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/edit_transaction_view.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_slidable.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile_price.dart';

import 'package:money_flow/features/transactions/views/widgets/linked_transaction_dialog.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transactionModel,
    required this.category,
    this.index = 0,
    this.onDelete,
    this.onEdit,
    this.onTap,
    this.isSlidableEnabled = true,
    this.tilePadding,
  });

  final TransactionModel transactionModel;
  final CategoryModel category;
  final int index;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;
  final bool isSlidableEnabled;
  final EdgeInsets? tilePadding;

  void _defaultOnTap(BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOnTap =
        onTap ?? (isSlidableEnabled ? () => _defaultOnTap(context) : null);

    final tile = ListTile(
      contentPadding: tilePadding ?? const EdgeInsets.symmetric(horizontal: 6),
      minVerticalPadding: 8,
      minTileHeight: 65,

      // icon
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: category.color.categoryContainerColor,
        child: Icon(category.icon, color: category.color.categoryIconColor),
      ),

      // title
      title: CustomText(
        transactionModel.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),

      // date
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            DateFormatter.dmy(transactionModel.date),
            style: const TextStyle(fontSize: 12),
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

      // amount
      trailing: TransactionTilePrice(transactionModel: transactionModel),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CustomSlidable(
        transactionModel: transactionModel,
        onDelete: onDelete,
        onEdit: onEdit ?? effectiveOnTap,
        enabled: isSlidableEnabled,
        child: effectiveOnTap != null
            ? GestureDetector(onTap: effectiveOnTap, child: tile)
            : tile,
      ),
    );
  }
}
