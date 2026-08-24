import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/settings/view_model/new_recurring_transaction_cubit/new_recurring_transaction_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/add_recurring_transactions_view_body.dart';

class AddRecurringTransactionsView extends StatelessWidget {
  const AddRecurringTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => NewRecurringTransactionCubit(HiveService()),
        child: const Scaffold(
          appBar: CustomAppBar(title: 'Add Recurring Transaction'),
          body: AddRecurringTransactionsViewBody(),
        ),
      ),
    );
  }
}
