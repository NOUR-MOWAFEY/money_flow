import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/transactions/views/add_transaction_view.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_floating_action_button.dart';
import 'package:money_flow/features/transactions_history/view_model/transactions_history_cubit/transactions_history_cubit.dart';
import 'package:money_flow/features/transactions_history/views/widgets/transactions_history_view_body.dart';

class TransactionsHistoryView extends StatelessWidget {
  const TransactionsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionsHistoryCubit(HiveService())..loadTransactions(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Scaffold(
          floatingActionButton: CustomFloatingActionButton(
            view: AddTransactionView(),
          ),
          body: SafeArea(child: TransactionsHistoryViewBody()),
        ),
      ),
    );
  }
}
