import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_cubit.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_state.dart';
import 'package:money_flow/features/environments/views/add_environment_expense_view.dart';
import 'package:money_flow/features/environments/views/create_environment_view.dart';
import 'package:money_flow/features/environments/views/widgets/environment_details_dialog_helper.dart';
import 'package:money_flow/features/environments/views/widgets/environment_details_success_body.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_floating_action_button.dart';

class EnvironmentDetailsViewBody extends StatelessWidget {
  const EnvironmentDetailsViewBody({super.key});

  void _openEdit(BuildContext context, EnvironmentModel env) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateEnvironmentView(environment: env),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvironmentDetailsCubit, EnvironmentDetailsState>(
      builder: (context, state) {
        if (state is EnvironmentDetailsLoading) {
          return const Scaffold(
            appBar: CustomAppBar(title: 'Loading...'),
            body: CustomLoading(),
          );
        }

        if (state is EnvironmentDetailsSuccess) {
          final env = state.environment;
          final isClosed = env.isClosed;

          return Scaffold(
            appBar: CustomAppBar(
              title: env.name,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit Environment',
                  onPressed: () => _openEdit(context, env),
                ),
              ],
            ),
            floatingActionButton: isClosed
                ? null
                : CustomFloatingActionButton(
                    view: BlocProvider.value(
                      value: context.read<EnvironmentDetailsCubit>(),
                      child: AddEnvironmentExpenseView(environment: env),
                    ),
                  ),
            body: EnvironmentDetailsSuccessBody(
              environment: env,
              totalSpent: state.totalSpent,
              expenses: state.expenses,
              onAddFunds: isClosed
                  ? null
                  : () => EnvironmentDetailsDialogHelper.showTopUp(context),
              onSettle: () =>
                  EnvironmentDetailsDialogHelper.showSettle(context, env),
              onDelete: () =>
                  EnvironmentDetailsDialogHelper.showDelete(context, env),
            ),
          );
        }

        return const Scaffold(
          appBar: CustomAppBar(title: 'Environments'),
          body: Center(
            child: Text(
              'Environment not found',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        );
      },
    );
  }
}
