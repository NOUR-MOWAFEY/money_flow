import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/validator.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';

class EditTransactionButton extends StatelessWidget {
  const EditTransactionButton({
    super.key,
    required this.transactionDataModel,
    this.transactionModel,
    this.onSave,
  });

  final TransactionDataModel transactionDataModel;
  final TransactionModel? transactionModel;
  final Future<void> Function(TransactionDataModel dataModel)? onSave;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Edit',
      onTap: () {
        Validator.checkAddTransactionFields(
          context,
          transactionDataModel,
          onValid: () async {
            if (onSave != null) {
              await onSave!(transactionDataModel);
            } else if (transactionModel != null) {
              await context.read<TransactionsCubit>().editTransaction(
                transactionModel!,
                amount: double.parse(
                  transactionDataModel.amountController.text.trim(),
                ),
                date: transactionDataModel.date.value,
                isExpense: transactionDataModel.transactionType.value ==
                    CategoryType.expenses,
                title: transactionDataModel.category.value!.title,
              );
            }

            if (!context.mounted) return;
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
