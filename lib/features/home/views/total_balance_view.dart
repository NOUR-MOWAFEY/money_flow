import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/views/environments_view.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';
import 'package:money_flow/features/home/views/widgets/total_balance_view_body.dart';

class TotalBalanceView extends StatelessWidget {
  const TotalBalanceView({super.key, this.environmentsCubit});

  final EnvironmentsCubit? environmentsCubit;

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      appBar: CustomAppBar(
        title: 'Total Balance',
        actions: [
          // Toggle balance visibility
          BlocBuilder<BalanceVisibilityCubit, bool>(
            builder: (context, isHidden) {
              return IconButton(
                icon: Icon(
                  isHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                tooltip: isHidden ? 'Show balance' : 'Hide balance',
                onPressed: () =>
                    context.read<BalanceVisibilityCubit>().toggle(),
              );
            },
          ),
          // Shortcut to EnvironmentsView
          IconButton(
            icon: const Icon(Icons.layers_outlined),
            tooltip: 'Environments',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EnvironmentsView(),
                ),
              );
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: TotalBalanceViewBody(),
      ),
    );

    if (environmentsCubit != null) {
      return BlocProvider.value(
        value: environmentsCubit!,
        child: content,
      );
    }

    return BlocProvider(
      create: (context) => EnvironmentsCubit(HiveService.instance),
      child: content,
    );
  }
}
