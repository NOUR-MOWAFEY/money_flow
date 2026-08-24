import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/views/widgets/add_transaction_view_buttons.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_fields.dart';

class AddTransactionViewBody extends StatefulWidget {
  const AddTransactionViewBody({super.key});

  @override
  State<AddTransactionViewBody> createState() => _AddTransactionViewBodyState();
}

class _AddTransactionViewBodyState extends State<AddTransactionViewBody> {
  late TransactionDataModel addTransactionModel;

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
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.viewPadding,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 18),

            // toggle switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: CustomToggleSwitch<CategoryType>(
                current: addTransactionModel.transactionType.value,
                
                values: CategoryType.values,
                onChanged: (CategoryType transactionType) {
                  addTransactionModel.category.value = null;
                  addTransactionModel.transactionType.value = transactionType;
                },
              ),
            ),

            const SizedBox(height: 32),

            // all fields
            TransactionFields(addTransactionModel: addTransactionModel),

            const SizedBox(height: 32),

            // add button + calculator button
            AddTransactionViewButtons(addTransactionModel: addTransactionModel),
          ],
        ),
      ),
    );
  }

  void _initializeFieldsData() {
    addTransactionModel = TransactionDataModel(
      amountController: TextEditingController(),
      date: ValueNotifier(DateTime.now()),
      transactionType: ValueNotifier(CategoryType.expenses),
      category: ValueNotifier(null),
    );
  }

  void _disposeFieldsData() {
    addTransactionModel.category.dispose();
    addTransactionModel.amountController.dispose();
    addTransactionModel.date.dispose();
    addTransactionModel.transactionType.dispose();
  }
}
