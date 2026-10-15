import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/utils/validator.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_cubit.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';

class EditEnvironmentExpenseButton extends StatelessWidget {
  const EditEnvironmentExpenseButton({
    super.key,
    required this.transactionDataModel,
    required this.environment,
    required this.expense,
  });

  final TransactionDataModel transactionDataModel;
  final EnvironmentModel environment;
  final EnvironmentExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Edit',
      onTap: () {
        Validator.checkAddTransactionFields(
          context,
          transactionDataModel,
          onValid: () async {
            final amount = double.parse(
              transactionDataModel.amountController.text.trim(),
            );
            final title = transactionDataModel.category.value!.title;
            final date = transactionDataModel.date.value;

            final difference = amount - expense.amount;
            if (difference > environment.currentBalance) {
              ShowToastification.warning(
                context,
                'Note: Expense exceeds current environment balance.',
              );
            }

            await context.read<EnvironmentDetailsCubit>().updateExpense(
                  expense: expense,
                  title: title,
                  amount: amount,
                  date: date,
                );

            if (!context.mounted) return;

            ShowToastification.success(context, 'Expense updated successfully');
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
