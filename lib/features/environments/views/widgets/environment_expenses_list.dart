import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_cubit.dart';
import 'package:money_flow/features/environments/views/edit_environment_expense_view.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_tile.dart';

class EnvironmentExpensesList extends StatelessWidget {
  const EnvironmentExpensesList({
    super.key,
    required this.environment,
    required this.expenses,
  });

  final EnvironmentModel environment;
  final List<EnvironmentExpenseModel> expenses;

  void _openEdit(BuildContext context, EnvironmentExpenseModel expense) {
    if (environment.isClosed) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<EnvironmentDetailsCubit>(),
          child: EditEnvironmentExpenseView(
            environment: environment,
            expense: expense,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isClosed = environment.isClosed;

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 4),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 2),
      itemBuilder: (context, index) {
        final expense = expenses[index];
        final txModel = TransactionModel(
          title: expense.title,
          amount: expense.amount,
          date: expense.date,
          isExpense: true,
        );
        final category = getCategory(
          expense.title,
          true,
          HiveService.instance,
        );

        return TransactionTile(
          transactionModel: txModel,
          category: category,
          index: index,
          onTap: isClosed ? null : () => _openEdit(context, expense),
          onEdit: isClosed ? null : () => _openEdit(context, expense),
          onDelete: isClosed
              ? null
              : () => context
                    .read<EnvironmentDetailsCubit>()
                    .deleteExpense(expense),
          isSlidableEnabled: !isClosed,
        );
      },
    );
  }
}
