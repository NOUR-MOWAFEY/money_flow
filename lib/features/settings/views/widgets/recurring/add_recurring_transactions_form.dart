import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/view_model/new_recurring_transaction_cubit/new_recurring_transaction_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transaction_fields.dart';

class AddRecurringTransactionsForm extends StatefulWidget {
  const AddRecurringTransactionsForm({super.key, required this.cubit});

  final NewRecurringTransactionCubit cubit;

  @override
  State<AddRecurringTransactionsForm> createState() =>
      _AddRecurringTransactionsFormState();
}

class _AddRecurringTransactionsFormState
    extends State<AddRecurringTransactionsForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.viewPadding,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 18),

            // Type toggle
            CustomToggleSwitch<CategoryType>(
              current: widget.cubit.dataModel.type.value,
              values: CategoryType.values,
              onChanged: (CategoryType transactionType) {
                widget.cubit.dataModel.category.value = null;
                widget.cubit.dataModel.type.value = transactionType;
              },
            ),

            const SizedBox(height: 32),

            RecurringTransactionFields(dataModel: widget.cubit.dataModel),

            const SizedBox(height: 32),

            CustomButton(
              title: 'Create Recurring',
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  widget.cubit.saveRecurringTransaction();
                }
              },
            ),

            const SizedBox(height: AppDimensions.viewBottomSpace),
          ],
        ),
      ),
    );
  }
}
