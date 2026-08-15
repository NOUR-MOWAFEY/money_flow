import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/home/views/widgets/custom_animated_toggle.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/views/widgets/edit_transaction_view_buttons.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_fields.dart';

class EditTransactionViewBody extends StatefulWidget {
  const EditTransactionViewBody({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  State<EditTransactionViewBody> createState() =>
      _EditTransactionViewBodyState();
}

class _EditTransactionViewBodyState extends State<EditTransactionViewBody> {
  late TransactionDataModel transactionDataModel;

  @override
  void initState() {
    _initializeFieldsData(context);
    super.initState();
  }

  @override
  void dispose() {
    _disposeFieldsData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ListView(
          children: [
            const SizedBox(height: 18),

            // toggle switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomAnimatedToggle(
                transactionType: transactionDataModel.transactionType.value,
                onChange: (CategoryType transactionType) {
                  transactionDataModel.category.value = null;
                  transactionDataModel.transactionType.value = transactionType;
                },
              ),
            ),

            const SizedBox(height: 32),

            // all fields
            TransactionFields(addTransactionModel: transactionDataModel),

            const SizedBox(height: 32),

            // edit button + calculator button
            EditTransactionViewButtons(
              transactionModel: widget.transactionModel,
              transactionDataModel: transactionDataModel,
            ),
          ],
        ),
      ),
    );
  }

  void _initializeFieldsData(BuildContext context) {
    final transaction = widget.transactionModel;

    // Look up the category from the already-loaded cubit state (no Hive read)
    final cubitState = context.read<TransactionsCubit>().state;
    final CategoryModel category = cubitState is TransactionsSuccess
        ? cubitState.findCategory(transaction.title, transaction.isExpense)
        : AppCategories.defaultCategory;

    transactionDataModel = TransactionDataModel(
      amountController: TextEditingController(
        text: transaction.amount.toString(),
      ),

      date: ValueNotifier(transaction.date),

      transactionType: ValueNotifier(
        transaction.isExpense ? CategoryType.expenses : CategoryType.income,
      ),

      category: ValueNotifier(
        CategoryModel(
          title: category.title,
          icon: category.icon,
          color: category.color,
          categoryType: category.categoryType,
        ),
      ),
    );
  }

  void _disposeFieldsData() {
    transactionDataModel.category.dispose();
    transactionDataModel.amountController.dispose();
    transactionDataModel.date.dispose();
    transactionDataModel.transactionType.dispose();
  }
}
