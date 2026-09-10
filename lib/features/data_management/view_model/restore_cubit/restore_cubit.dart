import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:money_flow/features/data_management/data/models/backup_payload.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';
import 'package:money_flow/features/data_management/data/services/restore_service.dart';

part 'restore_state.dart';

class RestoreCubit extends Cubit<RestoreState> {
  final RestoreService restoreService;

  RestoreCubit({this.restoreService = const RestoreService()})
      : super(const RestoreInitial());

  Future<void> pickFile() async {
    try {
      emit(const RestoreFileLoading());
      final picked = await restoreService.pickBackupFile();
      if (picked == null) {
        emit(const RestoreInitial());
        return;
      }

      final payload = restoreService.parseBackupJson(
        picked.content,
        fileName: picked.fileName,
      );

      if (payload.availableTypes.isEmpty) {
        emit(const RestoreFailure(
          errorMessage: 'This backup file does not contain any restorable data.',
        ));
        return;
      }

      emit(RestoreFileLoaded(
        payload: payload,
        selectedTypes: Set.from(payload.availableTypes),
      ));
    } catch (e) {
      emit(RestoreFailure(errorMessage: _sanitizeError(e)));
    }
  }

  void loadJsonContent(String jsonString, {String? fileName}) {
    try {
      emit(const RestoreFileLoading());
      final payload = restoreService.parseBackupJson(
        jsonString,
        fileName: fileName,
      );

      if (payload.availableTypes.isEmpty) {
        emit(const RestoreFailure(
          errorMessage: 'This backup file does not contain any restorable data.',
        ));
        return;
      }

      emit(RestoreFileLoaded(
        payload: payload,
        selectedTypes: Set.from(payload.availableTypes),
      ));
    } catch (e) {
      emit(RestoreFailure(errorMessage: _sanitizeError(e)));
    }
  }

  void toggleItem(BackupType type, bool? value) {
    final current = state;
    if (current is! RestoreFileLoaded) return;

    final updated = Set<BackupType>.from(current.selectedTypes);
    if (value == true) {
      updated.add(type);
    } else {
      updated.remove(type);
    }
    emit(current.copyWith(selectedTypes: updated));
  }

  void toggleSelectAll(bool? value) {
    final current = state;
    if (current is! RestoreFileLoaded) return;

    if (current.allSelected) {
      emit(current.copyWith(selectedTypes: const {}));
    } else {
      emit(current.copyWith(
        selectedTypes: Set.from(current.payload.availableTypes),
      ));
    }
  }

  void setRestoreMode(RestoreMode mode) {
    final current = state;
    if (current is! RestoreFileLoaded) return;
    emit(current.copyWith(mode: mode));
  }

  Future<void> restoreSelectedData() async {
    final current = state;
    if (current is! RestoreFileLoaded) return;

    if (current.selectedTypes.isEmpty) {
      emit(RestoreFailure(
        errorMessage: 'Please select at least one item type to restore.',
        payload: current.payload,
      ));
      return;
    }

    final payload = current.payload;
    final selectedTypes = current.selectedTypes;
    final mode = current.mode;

    emit(RestoreInProgress(
      payload: payload,
      selectedTypes: selectedTypes,
      mode: mode,
    ));

    try {
      await restoreService.restoreData(
        payload: payload,
        selectedTypes: selectedTypes,
        mode: mode,
      );

      int restoredCount = 0;
      for (final type in selectedTypes) {
        restoredCount += payload.countFor(type);
      }

      emit(RestoreSuccess(
        restoredCount: restoredCount,
        mode: mode,
      ));
    } catch (e) {
      emit(RestoreFailure(
        errorMessage: _sanitizeError(e),
        payload: payload,
      ));
    }
  }

  void clearFile() {
    emit(const RestoreInitial());
  }

  String _sanitizeError(dynamic error) {
    if (error is FormatException) {
      return error.message;
    }
    final str = error.toString();
    if (str.startsWith('Exception: ')) {
      return str.substring('Exception: '.length);
    }
    return str;
  }
}
