import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/cubits/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/models/add_transaction_model.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/utils/validator.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/custom_button.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({super.key, required this.addTransactionModel});
  final AddTransactionModel addTransactionModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CustomButton(
          title: 'Add',
          
          onTap: () {
            Validator.checkAddTransactionFields(
              context,
              addTransactionModel,
              onValid: () async {
                final transaction = TransactionModel(
                  title: addTransactionModel.category.value!.title,
                  amount: double.parse(
                    addTransactionModel.amountController.text.trim(),
                  ),
                  date: addTransactionModel.dateController.text,
                  isExpense:
                      addTransactionModel.transactionType.value ==
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
