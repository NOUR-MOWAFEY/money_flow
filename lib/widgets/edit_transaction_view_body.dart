import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/models/transaction_data_model.dart';
import 'package:money_flow/models/transaction_model.dart';
import 'package:money_flow/utils/get_category.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/edit_transaction_view_buttons.dart';
import 'package:money_flow/widgets/transaction_fields.dart';

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
    _initializeFieldsData();
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
                onChange: (TransactionType transactionType) {
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

  void _initializeFieldsData() {
    final transaction = widget.transactionModel;
    final category = getCategory(transaction.title, transaction.isExpense);

    transactionDataModel = TransactionDataModel(
      amountController: TextEditingController(
        text: transaction.amount.toString(),
      ),

      date: ValueNotifier(transaction.date),

      transactionType: ValueNotifier(
        transaction.isExpense
            ? TransactionType.expenses
            : TransactionType.income,
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
