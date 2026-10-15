import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/add_environment_expense_view_buttons.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/views/widgets/amount_field.dart';
import 'package:money_flow/features/transactions/views/widgets/category_field.dart';
import 'package:money_flow/features/transactions/views/widgets/date_field.dart';

class AddEnvironmentExpenseViewBody extends StatefulWidget {
  const AddEnvironmentExpenseViewBody({
    super.key,
    required this.environment,
  });

  final EnvironmentModel environment;

  @override
  State<AddEnvironmentExpenseViewBody> createState() =>
      _AddEnvironmentExpenseViewBodyState();
}

class _AddEnvironmentExpenseViewBodyState
    extends State<AddEnvironmentExpenseViewBody> {
  late final TransactionDataModel _dataModel;

  @override
  void initState() {
    super.initState();
    _dataModel = TransactionDataModel(
      amountController: TextEditingController(),
      date: ValueNotifier(DateTime.now()),
      transactionType: ValueNotifier(CategoryType.expenses),
      category: ValueNotifier(null),
    );
  }

  @override
  void dispose() {
    _dataModel.category.dispose();
    _dataModel.amountController.dispose();
    _dataModel.date.dispose();
    _dataModel.transactionType.dispose();
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
            const SizedBox(height: 24),
            AmountField(amountController: _dataModel.amountController),
            const SizedBox(height: 32),
            CategoryField(
              transactionType: _dataModel.transactionType,
              category: _dataModel.category,
            ),
            const SizedBox(height: 16),
            DateField(date: _dataModel.date),
            const SizedBox(height: 32),
            AddEnvironmentExpenseViewButtons(
              transactionDataModel: _dataModel,
              environment: widget.environment,
            ),
          ],
        ),
      ),
    );
  }
}
