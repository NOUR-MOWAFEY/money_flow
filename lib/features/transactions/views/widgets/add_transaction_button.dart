import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/core/utils/validator.dart';
import 'package:money_flow/features/home/views/widgets/custom_animated_toggle.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({super.key, required this.transactionDataModel});
  final TransactionDataModel transactionDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return CustomButton(
          title: 'Add',

          onTap: () {
            Validator.checkAddTransactionFields(
              context,
              transactionDataModel,
              onValid: () async {
                final transaction = TransactionModel(
                  title: transactionDataModel.category.value!.title,
                  amount: double.parse(
                    transactionDataModel.amountController.text.trim(),
                  ),
                  date: transactionDataModel.date.value,
                  isExpense:
                      transactionDataModel.transactionType.value ==
                      TransactionType.expenses,
                );
                await context.read<TransactionsCubit>().addTransaction(
                  transaction,
                );

                if (!context.mounted) return;

                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
