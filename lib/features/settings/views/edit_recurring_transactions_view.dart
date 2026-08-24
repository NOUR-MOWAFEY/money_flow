import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/view_model/edit_recurring_transaction_cubit/edit_recurring_transaction_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/edit_recurring_transactions_view_body.dart';

class EditRecurringTransactionsView extends StatelessWidget {
  const EditRecurringTransactionsView({
    super.key,
    required this.recurringTransaction,
  });

  final RecurringTransactionModel recurringTransaction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => EditRecurringTransactionCubit(
          recurringTransaction,
          HiveService(),
        ),
        child: const Scaffold(
          appBar: CustomAppBar(title: 'Edit Recurring Transaction'),
          body: EditRecurringTransactionsViewBody(),
        ),
      ),
    );
  }
}
