import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/get_category.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_data_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions/views/widgets/edit_transaction_view_buttons.dart';
import 'package:money_flow/features/transactions/views/widgets/transaction_fields.dart';

class EditTransactionViewBody extends StatefulWidget {
  const EditTransactionViewBody({
    super.key,
    required this.transactionModel,
    this.showTypeToggle = true,
    this.onSave,
  });

  final TransactionModel transactionModel;
  final bool showTypeToggle;
  final Future<void> Function(TransactionDataModel dataModel)? onSave;

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
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppDimensions.viewPadding,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 18),

            // toggle switch (optional, hidden when editing single-type expenses like in environments)
            if (widget.showTypeToggle) ...[
              CustomToggleSwitch<CategoryType>(
                current: transactionDataModel.transactionType.value,
                values: CategoryType.values,
                onChanged: (CategoryType transactionType) {
                  transactionDataModel.category.value = null;
                  transactionDataModel.transactionType.value = transactionType;
                },
              ),
              const SizedBox(height: 32),
            ],

            // all fields
            TransactionFields(addTransactionModel: transactionDataModel),

            const SizedBox(height: 32),

            // edit button + calculator button
            EditTransactionViewButtons(
              transactionModel: widget.transactionModel,
              transactionDataModel: transactionDataModel,
              onSave: widget.onSave,
            ),
          ],
        ),
      ),
    );
  }

  void _initializeFieldsData(BuildContext context) {
    final transaction = widget.transactionModel;

    CategoryModel? category;
    try {
      final cubitState = context.read<TransactionsCubit>().state;
      if (cubitState is TransactionsSuccess) {
        category = cubitState.findCategory(
          transaction.title,
          transaction.isExpense,
        );
      }
    } catch (_) {}

    category ??= getCategory(
      transaction.title,
      transaction.isExpense,
      HiveService.instance,
    );

    final amountText = transaction.amount % 1 == 0
        ? transaction.amount.toInt().toString()
        : transaction.amount.toString();

    transactionDataModel = TransactionDataModel(
      amountController: TextEditingController(text: amountText),
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
