part of 'restore_cubit.dart';

@immutable
sealed class RestoreState {
  const RestoreState();
}

final class RestoreInitial extends RestoreState {
  const RestoreInitial();
}

final class RestoreFileLoading extends RestoreState {
  const RestoreFileLoading();
}

final class RestoreFileLoaded extends RestoreState {
  final BackupDataPayload payload;
  final Set<BackupType> selectedTypes;
  final RestoreMode mode;

  const RestoreFileLoaded({
    required this.payload,
    required this.selectedTypes,
    this.mode = RestoreMode.merge,
  });

  bool isSelected(BackupType type) => selectedTypes.contains(type);

  bool get allSelected => selectedTypes.length == payload.availableTypes.length;

  bool get noneSelected => selectedTypes.isEmpty;

  bool? get selectAllValue {
    if (allSelected) return true;
    if (noneSelected) return false;
    return null;
  }

  RestoreFileLoaded copyWith({
    BackupDataPayload? payload,
    Set<BackupType>? selectedTypes,
    RestoreMode? mode,
  }) {
    return RestoreFileLoaded(
      payload: payload ?? this.payload,
      selectedTypes: selectedTypes ?? this.selectedTypes,
      mode: mode ?? this.mode,
    );
  }
}

final class RestoreInProgress extends RestoreState {
  final BackupDataPayload payload;
  final Set<BackupType> selectedTypes;
  final RestoreMode mode;

  const RestoreInProgress({
    required this.payload,
    required this.selectedTypes,
    required this.mode,
  });
}

final class RestoreSuccess extends RestoreState {
  final int restoredCount;
  final RestoreMode mode;

  const RestoreSuccess({
    required this.restoredCount,
    required this.mode,
  });
}

final class RestoreFailure extends RestoreState {
  final String errorMessage;
  final BackupDataPayload? payload;

  const RestoreFailure({
    required this.errorMessage,
    this.payload,
  });
}
