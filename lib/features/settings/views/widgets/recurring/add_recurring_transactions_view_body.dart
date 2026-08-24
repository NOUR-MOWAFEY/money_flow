import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/settings/view_model/new_recurring_transaction_cubit/new_recurring_transaction_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/add_recurring_transactions_form.dart';

class AddRecurringTransactionsViewBody extends StatelessWidget {
  const AddRecurringTransactionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      NewRecurringTransactionCubit,
      NewRecurringTransactionState
    >(
      listener: (context, state) {
        if (state is NewRecurringTransactionSuccess) {
          ShowToastification.success(
            context,
            'Recurring transaction added successfully',
          );
          Navigator.pop(context);
        } else if (state is NewRecurringTransactionFailure) {
          ShowToastification.failure(context, state.errorMessage);
        }
      },

      builder: (context, state) {
        final cubit = context.read<NewRecurringTransactionCubit>();

        if (state is NewRecurringTransactionLoading) {
          return const CustomLoading();
        }

        return AddRecurringTransactionsForm(cubit: cubit);
      },
    );
  }
}
