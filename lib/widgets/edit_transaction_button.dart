import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/cubits/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/utils/validator.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/custom_button.dart';

class EditTransactionButton extends StatelessWidget {
  const EditTransactionButton({
    super.key,
    required this.transactionDataModel,
    required this.transactionModel,
  });

  final TransactionDataModel transactionDataModel;
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return CustomButton(
          title: 'Edit',

          onTap: () {
            Validator.checkAddTransactionFields(
              context,
              transactionDataModel,
              onValid: () async {
                await context.read<TransactionsCubit>().editTransaction(
                  transactionModel,

                  amount: double.parse(
                    transactionDataModel.amountController.text.trim(),
                  ),

                  date: transactionDataModel.date.value,

                  isExpense:
                      transactionDataModel.transactionType.value ==
                      TransactionType.expenses,

                  title: transactionDataModel.category.value!.title,
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
