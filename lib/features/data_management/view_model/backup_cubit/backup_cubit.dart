import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/services/backup_service.dart';

part 'backup_state.dart';

class BackupCubit extends Cubit<BackupState> {
  final BackupService backupService;

  BackupCubit({this.backupService = const BackupService()})
      : super(BackupInitial(selectedTypes: Set.from(BackupType.values)));

  bool isSelected(BackupType type) => state.selectedTypes.contains(type);

  bool get allSelected =>
      state.selectedTypes.length == BackupType.values.length;

  bool get noneSelected => state.selectedTypes.isEmpty;

  bool? get selectAllValue {
    if (allSelected) return true;
    if (noneSelected) return false;
    return null;
  }

  void toggleSelectAll(bool? value) {
    if (allSelected) {
      emit(BackupSelectionChanged(selectedTypes: const {}));
    } else {
      emit(BackupSelectionChanged(
        selectedTypes: Set.from(BackupType.values),
      ));
    }
  }

  void toggleItem(BackupType type, bool? value) {
    final updated = Set<BackupType>.from(state.selectedTypes);
    if (value == true) {
      updated.add(type);
    } else {
      updated.remove(type);
    }
    emit(BackupSelectionChanged(selectedTypes: updated));
  }

  Future<void> saveToDevice() async {
    if (state.selectedTypes.isEmpty) {
      emit(BackupExportFailure(
        selectedTypes: state.selectedTypes,
        errorMessage: 'Please select at least one item to back up.',
      ));
      return;
    }

    emit(BackupExporting(selectedTypes: state.selectedTypes));

    try {
      final outputPath =
          await backupService.saveBackupToDevice(state.selectedTypes);
      if (outputPath != null) {
        emit(BackupSaveSuccess(
          selectedTypes: state.selectedTypes,
          filePath: outputPath,
        ));
      } else {
        emit(BackupSelectionChanged(selectedTypes: state.selectedTypes));
      }
    } catch (e) {
      emit(BackupExportFailure(
        selectedTypes: state.selectedTypes,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> shareBackup() async {
    if (state.selectedTypes.isEmpty) {
      emit(BackupExportFailure(
        selectedTypes: state.selectedTypes,
        errorMessage: 'Please select at least one item to back up.',
      ));
      return;
    }

    emit(BackupExporting(selectedTypes: state.selectedTypes));

    try {
      final file = await backupService.createBackupFile(state.selectedTypes);
      await backupService.shareBackup(state.selectedTypes);
      emit(BackupExportSuccess(
        selectedTypes: state.selectedTypes,
        filePath: file.path,
      ));
    } catch (e) {
      emit(BackupExportFailure(
        selectedTypes: state.selectedTypes,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> exportBackup() => shareBackup();
}
