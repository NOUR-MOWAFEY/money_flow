import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/data_management/view_model/backup_cubit/backup_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/export_options_bottom_sheet.dart';

class BackupExportButton extends StatelessWidget {
  const BackupExportButton({super.key});

  void _onExportPressed(BuildContext context) {
    final cubit = context.read<BackupCubit>();

    if (cubit.noneSelected) {
      ShowToastification.warning(
        context,
        'Please select at least one item to back up.',
      );
      return;
    }

    ExportOptionsBottomSheet.show(
      context,
      onSaveToDevice: cubit.saveToDevice,
      onShare: cubit.shareBackup,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExporting = context.select<BackupCubit, bool>(
      (cubit) => cubit.state is BackupExporting,
    );

    return CustomButton(
      title: 'Export JSON File',
      onTap: isExporting ? null : () => _onExportPressed(context),
      child: isExporting
          ? const Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            )
          : null,
    );
  }
}
