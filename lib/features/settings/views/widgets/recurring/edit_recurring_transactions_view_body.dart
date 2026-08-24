import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/settings/view_model/edit_recurring_transaction_cubit/edit_recurring_transaction_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/edit_recurring_transactions_form.dart';

class EditRecurringTransactionsViewBody extends StatelessWidget {
  const EditRecurringTransactionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      EditRecurringTransactionCubit,
      EditRecurringTransactionState
    >(
      listener: (context, state) {
        if (state is EditRecurringTransactionSuccess) {
          ShowToastification.success(
            context,
            'Recurring transaction updated successfully',
          );
          Navigator.pop(context);
        } else if (state is EditRecurringTransactionFailure) {
          ShowToastification.failure(context, state.errorMessage);
        }
      },

      builder: (context, state) {
        final cubit = context.read<EditRecurringTransactionCubit>();

        if (state is EditRecurringTransactionLoading) {
          return const CustomLoading();
        }

        return EditRecurringTransactionsForm(cubit: cubit);
      },
    );
  }
}
