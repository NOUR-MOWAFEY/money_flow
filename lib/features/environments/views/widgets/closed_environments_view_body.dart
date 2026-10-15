import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_state.dart';
import 'package:money_flow/features/environments/views/create_environment_view.dart';
import 'package:money_flow/features/environments/views/widgets/closed_environments_empty_state.dart';
import 'package:money_flow/features/environments/views/widgets/closed_environments_list.dart';

class ClosedEnvironmentsViewBody extends StatelessWidget {
  const ClosedEnvironmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvironmentsCubit, EnvironmentsState>(
      builder: (context, state) {
        if (state is EnvironmentsLoading) {
          return const CustomLoading();
        }

        if (state is EnvironmentsSuccess) {
          final closed = state.environments.where((e) => e.isClosed).toList();

          if (closed.isEmpty) {
            return const ClosedEnvironmentsEmptyState();
          }

          return ClosedEnvironmentsList(
            closedEnvironments: closed,
            onLongPressEnvironment: (env) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateEnvironmentView(environment: env),
                ),
              );
            },
          );
        }

        return const Center(
          child: Text(
            'Failed to load closed environments',
            style: TextStyle(color: Colors.white70),
          ),
        );
      },
    );
  }
}
