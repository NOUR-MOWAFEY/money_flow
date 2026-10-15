import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/views/closed_environments_view.dart';
import 'package:money_flow/features/environments/views/create_environment_view.dart';
import 'package:money_flow/features/environments/views/widgets/environments_view_body.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_floating_action_button.dart';

class EnvironmentsView extends StatelessWidget {
  const EnvironmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnvironmentsCubit(HiveService.instance),
      child: Builder(
        builder: (context) {
          final cubit = context.read<EnvironmentsCubit>();

          return Scaffold(
            appBar: CustomAppBar(
              title: 'Environments',
              actions: [
                IconButton(
                  icon: const Icon(Icons.history_rounded),
                  tooltip: 'Closed Environments',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: cubit,
                          child: const ClosedEnvironmentsView(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: const CustomFloatingActionButton(
              view: CreateEnvironmentView(),
            ),
            body: const EnvironmentsViewBody(),
          );
        },
      ),
    );
  }
}
