import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/view_model/edit_recurring_transaction_cubit/edit_recurring_transaction_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/edit_recurring_transactions_buttons.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transaction_fields.dart';

class EditRecurringTransactionsForm extends StatefulWidget {
  const EditRecurringTransactionsForm({super.key, required this.cubit});

  final EditRecurringTransactionCubit cubit;

  @override
  State<EditRecurringTransactionsForm> createState() =>
      _EditRecurringTransactionsFormState();
}

class _EditRecurringTransactionsFormState
    extends State<EditRecurringTransactionsForm> {
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

            EditRecurringTransactionsButtons(
              cubit: widget.cubit,
              formKey: formKey,
            ),

            const SizedBox(height: AppDimensions.viewBottomSpace),
          ],
        ),
      ),
    );
  }
}
