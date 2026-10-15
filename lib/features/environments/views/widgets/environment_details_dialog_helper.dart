import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_confirmation_dialog.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_cubit.dart';
import 'package:money_flow/features/environments/view_models/environments_cubit/environments_cubit.dart';
import 'package:money_flow/features/environments/views/widgets/settle_environment_dialog.dart';
import 'package:money_flow/features/environments/views/widgets/top_up_bottom_sheet.dart';

abstract class EnvironmentDetailsDialogHelper {
  static void showTopUp(BuildContext context) {
    final cubit = context.read<EnvironmentDetailsCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TopUpBottomSheet(
        onTopUp: (amount, deductFromMain) {
          cubit.topUp(amount: amount, deductFromMainBalance: deductFromMain);
          ShowToastification.success(context, 'Funds added to environment');
        },
      ),
    );
  }

  static void showSettle(BuildContext context, EnvironmentModel environment) {
    final envsCubit = context.read<EnvironmentsCubit>();
    showDialog(
      context: context,
      builder: (_) => DialogOpenAnimation(
        child: SettleEnvironmentDialog(
          environment: environment,
          onConfirm: (returnRemainder) {
            envsCubit.settleAndCloseEnvironment(
              environment: environment,
              returnRemainderToMain: returnRemainder,
            );
            ShowToastification.success(
              context,
              'Environment "${environment.name}" completed',
            );
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  static void showDelete(BuildContext context, EnvironmentModel environment) {
    final envsCubit = context.read<EnvironmentsCubit>();
    ShowConfirmationDialog.show(
      context,
      title: 'Delete Environment',
      description:
          'Are you sure you want to delete "${environment.name}"? This action is permanent and cannot be undone. Any related transactions in the main balance will be unlocked and can be managed or deleted directly.',
      confirmTitle: 'Delete',
      cancelTitle: 'Cancel',
      onConfirm: () {
        envsCubit.deleteEnvironment(environment);
        ShowToastification.success(context, 'Environment deleted');
        Navigator.of(context).pop();
      },
    );
  }
}
