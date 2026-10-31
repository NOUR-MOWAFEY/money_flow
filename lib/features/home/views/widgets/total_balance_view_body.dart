import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_state.dart';
import 'package:money_flow/features/environments/views/create_environment_view.dart';
import 'package:money_flow/features/environments/views/environment_details_view.dart';
import 'package:money_flow/features/environments/views/environments_view.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';
import 'package:money_flow/features/home/views/widgets/environments_balance_section.dart';
import 'package:money_flow/features/home/views/widgets/main_balance_details_card.dart';
import 'package:money_flow/features/home/views/widgets/total_balance_hero_card.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';
import 'package:money_flow/features/transactions/view_models/transactions_cubit/transactions_cubit.dart';
import 'package:money_flow/features/transactions_history/views/transactions_history_view.dart';

class TotalBalanceViewBody extends StatelessWidget {
  const TotalBalanceViewBody({super.key});

  void _openEnvironmentDetails(BuildContext context, String envId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EnvironmentDetailsView(environmentId: envId),
      ),
    );
  }

  void _openManageEnvironments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EnvironmentsView(),
      ),
    );
  }

  void _openCreateEnvironment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateEnvironmentView(),
      ),
    );
  }

  void _openTransactionsHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const TransactionsHistoryView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, _) {
        final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';

        return BlocBuilder<BalanceVisibilityCubit, bool>(
          builder: (context, isHidden) {
            return BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, txState) {
                return BlocBuilder<EnvironmentsCubit, EnvironmentsState>(
                  builder: (context, envState) {
                    if (txState is TransactionsLoading ||
                        envState is EnvironmentsLoading) {
                      return const CustomLoading();
                    }

                    final double mainBalance =
                        txState is TransactionsSuccess ? txState.balance : 0.0;

                    final transactions = txState is TransactionsSuccess
                        ? txState.transactions
                        : <TransactionModel>[];

                    final totalIncome = transactions
                        .where((t) => !t.isExpense)
                        .fold(0.0, (sum, t) => sum + t.amount);

                    final totalExpense = transactions
                        .where((t) => t.isExpense)
                        .fold(0.0, (sum, t) => sum + t.amount);

                    final environments = envState is EnvironmentsSuccess
                        ? envState.environments
                        : <EnvironmentModel>[];

                    final double envsBalance = envState is EnvironmentsSuccess
                        ? envState.totalIsolatedBalance
                        : 0.0;

                    final int activeCount = envState is EnvironmentsSuccess
                        ? envState.activeCount
                        : 0;

                    final double totalBalance = mainBalance + envsBalance;

                    return ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.viewPadding,
                        vertical: 16,
                      ),
                      children: [
                        // Hero Total Balance Card
                        TotalBalanceHeroCard(
                          totalBalance: totalBalance,
                          mainBalance: mainBalance,
                          environmentsBalance: envsBalance,
                          currency: currency,
                          activeEnvironmentsCount: activeCount,
                          isHidden: isHidden,
                        ),

                        const SizedBox(height: 20),

                        // Main Balance Breakdown Card
                        MainBalanceDetailsCard(
                          mainBalance: mainBalance,
                          currency: currency,
                          totalIncome: totalIncome,
                          totalExpense: totalExpense,
                          transactionCount: transactions.length,
                          isHidden: isHidden,
                          onTapHistory: () => _openTransactionsHistory(context),
                        ),

                        const SizedBox(height: 24),

                        // Environments Breakdown Section
                        EnvironmentsBalanceSection(
                          environments: environments,
                          currency: currency,
                          isHidden: isHidden,
                          onTapEnvironment: (id) =>
                              _openEnvironmentDetails(context, id),
                          onManageEnvironments: () =>
                              _openManageEnvironments(context),
                          onCreateEnvironment: () =>
                              _openCreateEnvironment(context),
                        ),

                        const SizedBox(height: 40),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
