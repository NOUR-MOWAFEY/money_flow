import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/data_management/data/models/backup_payload.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';
import 'package:money_flow/features/data_management/view_model/restore_cubit/restore_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_checklist.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_confirm_dialog.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_file_header.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_mode_selector.dart';

class RestoreContentView extends StatelessWidget {
  const RestoreContentView({super.key});

  void _onRestorePressed(
    BuildContext context,
    RestoreCubit cubit,
    BackupDataPayload payload,
    Set<BackupType> selectedTypes,
    RestoreMode mode,
  ) {
    if (selectedTypes.isEmpty) {
      ShowToastification.warning(
        context,
        'Please select at least one item to restore.',
      );
      return;
    }

    int totalSelected = 0;
    for (final type in selectedTypes) {
      totalSelected += payload.countFor(type);
    }

    RestoreConfirmDialog.show(
      context,
      mode: mode,
      itemCount: totalSelected,
      onConfirm: cubit.restoreSelectedData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestoreCubit>();
    final state = context.watch<RestoreCubit>().state;

    final isBusy = state is RestoreInProgress;

    final BackupDataPayload payload = state is RestoreFileLoaded
        ? state.payload
        : state is RestoreInProgress
            ? state.payload
            : (state as RestoreFailure).payload!;

    final Set<BackupType> selectedTypes = state is RestoreFileLoaded
        ? state.selectedTypes
        : state is RestoreInProgress
            ? state.selectedTypes
            : Set.from(payload.availableTypes);

    final RestoreMode mode = state is RestoreFileLoaded
        ? state.mode
        : state is RestoreInProgress
            ? state.mode
            : RestoreMode.merge;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.topSpace),
          RestoreFileHeader(
            payload: payload,
            onChangeFile: cubit.pickFile,
            isBusy: isBusy,
          ),
          const SizedBox(height: 24),
          const CustomText(
            'What do you want to restore?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          RestoreChecklist(
            payload: payload,
            selectedTypes: selectedTypes,
            onToggleSelectAll: isBusy ? (_) {} : cubit.toggleSelectAll,
            onToggleItem: isBusy ? (type, value) {} : cubit.toggleItem,
          ),
          const SizedBox(height: 24),
          RestoreModeSelector(
            currentMode: mode,
            onModeChanged: cubit.setRestoreMode,
            isBusy: isBusy,
          ),
          const SizedBox(height: 32),
          CustomButton(
            title: 'Restore Selected Data',
            color: mode == RestoreMode.replace
                ? AppColors.error
                : AppColors.primary,
            onTap: isBusy
                ? null
                : () => _onRestorePressed(
                      context,
                      cubit,
                      payload,
                      selectedTypes,
                      mode,
                    ),
            child: isBusy
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
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
