import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/settings/view_model/edit_recurring_transaction_cubit/edit_recurring_transaction_cubit.dart';

class EditRecurringTransactionsButtons extends StatelessWidget {
  const EditRecurringTransactionsButtons({
    super.key,
    required this.cubit,
    required this.formKey,
  });

  final EditRecurringTransactionCubit cubit;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: 'Delete',
            color: Colors.red.withAlpha(200),
            onTap: () async {
              await cubit.deleteRecurringTransaction();
            },
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: CustomButton(
            title: 'Save Changes',
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                cubit.updateRecurringTransaction();
              }
            },
          ),
        ),
      ],
    );
  }
}
