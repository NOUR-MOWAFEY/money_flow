import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/services/reset_service.dart';

part 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  final ResetService resetService;

  ResetCubit({this.resetService = const ResetService()})
      : super(ResetInitial(selectedTypes: Set.from(BackupType.values)));

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
      emit(ResetSelectionChanged(selectedTypes: const {}));
    } else {
      emit(ResetSelectionChanged(
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
    emit(ResetSelectionChanged(selectedTypes: updated));
  }

  int get selectedItemsCount =>
      resetService.getTotalCountForTypes(state.selectedTypes);

  Future<void> resetSelectedData() async {
    if (state.selectedTypes.isEmpty) {
      emit(ResetFailure(
        selectedTypes: state.selectedTypes,
        errorMessage: 'Please select at least one item to reset.',
      ));
      return;
    }

    final selected = state.selectedTypes;
    final totalCount = resetService.getTotalCountForTypes(selected);

    emit(ResetInProgress(selectedTypes: selected));

    try {
      await resetService.resetData(selected);
      emit(ResetSuccess(
        selectedTypes: selected,
        deletedCount: totalCount,
      ));
    } catch (e) {
      emit(ResetFailure(
        selectedTypes: selected,
        errorMessage: _sanitizeError(e),
      ));
    }
  }

  String _sanitizeError(dynamic error) {
    final str = error.toString();
    if (str.startsWith('Exception: ')) {
      return str.substring('Exception: '.length);
    }
    return str;
  }
}
