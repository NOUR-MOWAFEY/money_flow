import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_flow/cubits/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/views/edit_transaction_view.dart';

class CustomSlidable extends StatelessWidget {
  const CustomSlidable({
    super.key,
    required this.child,
    required this.transactionModel,
  });
  final Widget child;
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: StretchMotion(),
        extentRatio: .4,
        children: _slidableChildren(context),
      ),

      child: child,
    );
  }

  List<Widget> _slidableChildren(BuildContext context) {
    return [
      SlidableAction(
        onPressed: (_) async => await context
            .read<TransactionsCubit>()
            .deleteTransaction(transactionModel),
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        // label: 'Delete',
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),

      SlidableAction(
        onPressed: (context) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EditTransactionView(transactionModel: transactionModel),
          ),
        ),

        backgroundColor: Color.fromARGB(255, 73, 188, 254),
        foregroundColor: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        icon: Icons.edit_rounded,
        // label: 'Edit',
      ),
    ];
  }
}
