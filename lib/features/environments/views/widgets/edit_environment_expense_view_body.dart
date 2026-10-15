import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/environments/data/models/environment_expense_model.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/edit_environment_expense_view_buttons.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/views/widgets/amount_field.dart';
import 'package:money_flow/features/transactions/views/widgets/category_field.dart';
import 'package:money_flow/features/transactions/views/widgets/date_field.dart';

class EditEnvironmentExpenseViewBody extends StatefulWidget {
  const EditEnvironmentExpenseViewBody({
    super.key,
    required this.environment,
    required this.expense,
  });

  final EnvironmentModel environment;
  final EnvironmentExpenseModel expense;

  @override
  State<EditEnvironmentExpenseViewBody> createState() =>
      _EditEnvironmentExpenseViewBodyState();
}

class _EditEnvironmentExpenseViewBodyState
    extends State<EditEnvironmentExpenseViewBody> {
  late final TransactionDataModel _dataModel;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    final category = getCategory(expense.title, true, HiveService.instance);

    _dataModel = TransactionDataModel(
      amountController: TextEditingController(
        text: expense.amount % 1 == 0
            ? expense.amount.toInt().toString()
            : expense.amount.toString(),
      ),
      date: ValueNotifier(expense.date),
      transactionType: ValueNotifier(CategoryType.expenses),
      category: ValueNotifier(category),
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
            EditEnvironmentExpenseViewButtons(
              transactionDataModel: _dataModel,
              environment: widget.environment,
              expense: widget.expense,
            ),
          ],
        ),
      ),
    );
  }
}
