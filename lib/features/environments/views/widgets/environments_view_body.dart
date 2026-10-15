import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_state.dart';
import 'package:money_flow/features/environments/views/create_environment_view.dart';
import 'package:money_flow/features/environments/views/environment_details_view.dart';
import 'package:money_flow/features/environments/views/widgets/active_environments_list.dart';
import 'package:money_flow/features/environments/views/widgets/environments_empty_state.dart';
import 'package:money_flow/features/environments/views/widgets/environments_summary_card.dart';
import 'package:money_flow/features/environments/views/widgets/no_active_environments_card.dart';

class EnvironmentsViewBody extends StatelessWidget {
  const EnvironmentsViewBody({super.key});

  void _openDetails(BuildContext context, String envId) {
    final envsCubit = context.read<EnvironmentsCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: envsCubit,
          child: EnvironmentDetailsView(environmentId: envId),
        ),
      ),
    );
  }

  void _openEdit(BuildContext context, EnvironmentModel env) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateEnvironmentView(environment: env),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvironmentsCubit, EnvironmentsState>(
      builder: (context, state) {
        if (state is EnvironmentsLoading) {
          return const CustomLoading();
        }

        if (state is EnvironmentsSuccess) {
          if (state.environments.isEmpty) {
            return const EnvironmentsEmptyState();
          }

          final activeEnvironments =
              state.environments.where((e) => !e.isClosed).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.viewPadding,
              vertical: 16,
            ),
            children: [
              EnvironmentsSummaryCard(
                totalBalance: state.totalIsolatedBalance,
                activeCount: state.activeCount,
              ),
              const SizedBox(height: 20),
              if (activeEnvironments.isEmpty)
                const NoActiveEnvironmentsCard()
              else
                ActiveEnvironmentsList(
                  activeEnvironments: activeEnvironments,
                  onTapEnvironment: (id) => _openDetails(context, id),
                  onLongPressEnvironment: (env) => _openEdit(context, env),
                ),
              const SizedBox(height: 80),
            ],
          );
        }

        return const Center(
          child: Text(
            'Failed to load environments',
            style: TextStyle(color: Colors.white70),
          ),
        );
      },
    );
  }
}
