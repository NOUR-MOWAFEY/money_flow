part of 'backup_cubit.dart';

@immutable
sealed class BackupState {
  final Set<BackupType> selectedTypes;
  const BackupState({required this.selectedTypes});
}

final class BackupInitial extends BackupState {
  const BackupInitial({required super.selectedTypes});
}

final class BackupSelectionChanged extends BackupState {
  const BackupSelectionChanged({required super.selectedTypes});
}

final class BackupExporting extends BackupState {
  const BackupExporting({required super.selectedTypes});
}

final class BackupExportSuccess extends BackupState {
  final String filePath;
  const BackupExportSuccess({
    required super.selectedTypes,
    required this.filePath,
  });
}

final class BackupSaveSuccess extends BackupState {
  final String filePath;
  const BackupSaveSuccess({
    required super.selectedTypes,
    required this.filePath,
  });
}

final class BackupExportFailure extends BackupState {
  final String errorMessage;
  const BackupExportFailure({
    required super.selectedTypes,
    required this.errorMessage,
  });
}
