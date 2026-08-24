import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/settings/view_model/recurring_transactions_cubit/recurring_transactions_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/custom_add_recurring_button.dart';
import 'package:money_flow/features/settings/views/widgets/recurring/recurring_transactions_view_body.dart';

class RecurringTransactionsView extends StatelessWidget {
  const RecurringTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecurringTransactionsCubit(HiveService()),
      child: const Scaffold(
        appBar: CustomAppBar(
          title: 'Recurring Transactions',
          actions: [CustomAddRecurringButton()],
        ),
        body: RecurringTransactionsViewBody(),
      ),
    );
  }
}
