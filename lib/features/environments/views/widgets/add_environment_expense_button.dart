import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/utils/validator.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_cubit.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';

class AddEnvironmentExpenseButton extends StatelessWidget {
  const AddEnvironmentExpenseButton({
    super.key,
    required this.transactionDataModel,
    required this.environment,
  });

  final TransactionDataModel transactionDataModel;
  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Add',
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

            if (amount > environment.currentBalance) {
              ShowToastification.warning(
                context,
                'Note: Expense exceeds current environment balance.',
              );
            }

            await context.read<EnvironmentDetailsCubit>().addExpense(
                  title: title,
                  amount: amount,
                  date: date,
                );

            if (!context.mounted) return;

            ShowToastification.success(context, 'Expense added successfully');
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
