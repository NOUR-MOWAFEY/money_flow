import 'package:flutter/material.dart';
import 'package:money_flow/models/add_transaction_model.dart';
import 'package:money_flow/utils/date_formatter.dart';
import 'package:money_flow/widgets/add_transaction_fields.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/add_transaction_button.dart';

class AddTransactionViewBody extends StatefulWidget {
  const AddTransactionViewBody({super.key});

  @override
  State<AddTransactionViewBody> createState() => _AddTransactionViewBodyState();
}

class _AddTransactionViewBodyState extends State<AddTransactionViewBody> {
  late AddTransactionModel addTransactionModel;

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
                onChange: (TransactionType transactionType) {
                  addTransactionModel.category.value = null;
                  addTransactionModel.transactionType.value = transactionType;
                },
              ),
            ),

            const SizedBox(height: 32),

            // all fields
            AddTransactionFields(addTransactionModel: addTransactionModel),

            const SizedBox(height: 32),

            // save button
            AddTransactionButton(addTransactionModel: addTransactionModel),
          ],
        ),
      ),
    );
  }

  void _initializeFieldsData() {
    addTransactionModel = AddTransactionModel(
      amountController: TextEditingController(),
      dateController: TextEditingController(),
      transactionType: ValueNotifier(TransactionType.expenses),
      category: ValueNotifier(null),
    );

    addTransactionModel.dateController.text = DateFormatter.dateNow;
  }

  void _disposeFieldsData() {
    addTransactionModel.category.dispose();
    addTransactionModel.amountController.dispose();
    addTransactionModel.dateController.dispose();
    addTransactionModel.transactionType.dispose();
  }
}
