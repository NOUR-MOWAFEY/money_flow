import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/views/edit_transaction_view.dart';

import 'package:money_flow/features/transactions/views/widgets/linked_transaction_dialog.dart';

class CustomSlidable extends StatelessWidget {
  const CustomSlidable({
    super.key,
    required this.child,
    this.transactionModel,
    this.onDelete,
    this.onEdit,
    this.enabled = true,
  });

  final Widget child;
  final TransactionModel? transactionModel;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: .4,
        children: _slidableChildren(context),
      ),
      child: child,
    );
  }

  List<Widget> _slidableChildren(BuildContext context) {
    final isLinked = transactionModel?.isEnvironmentActive() ?? false;

    return [
      SlidableAction(
        onPressed: (ctx) async {
          if (isLinked) {
            showLinkedTransactionDialog(context, transactionModel!);
            return;
          }
          if (onDelete != null) {
            onDelete!();
          } else if (transactionModel != null) {
            await ctx.read<TransactionsCubit>().deleteTransaction(
              transactionModel!,
            );
          }
        },
        backgroundColor:
            isLinked ? Colors.blueGrey.shade700 : const Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: isLinked ? Icons.lock_outline_rounded : Icons.delete,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      SlidableAction(
        onPressed: (ctx) {
          if (isLinked) {
            showLinkedTransactionDialog(context, transactionModel!);
            return;
          }
          if (onEdit != null) {
            onEdit!();
          } else if (transactionModel != null) {
            Navigator.of(ctx, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) =>
                    EditTransactionView(transactionModel: transactionModel!),
              ),
            );
          }
        },
        backgroundColor: isLinked
            ? Colors.blueGrey.shade600
            : const Color.fromARGB(255, 73, 188, 254),
        foregroundColor: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        icon: isLinked ? Icons.info_outline_rounded : Icons.edit_rounded,
      ),
    ];
  }
}
