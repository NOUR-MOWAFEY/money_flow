part of 'reset_cubit.dart';

@immutable
sealed class ResetState {
  final Set<BackupType> selectedTypes;
  const ResetState({required this.selectedTypes});
}

final class ResetInitial extends ResetState {
  const ResetInitial({required super.selectedTypes});
}

final class ResetSelectionChanged extends ResetState {
  const ResetSelectionChanged({required super.selectedTypes});
}

final class ResetInProgress extends ResetState {
  const ResetInProgress({required super.selectedTypes});
}

final class ResetSuccess extends ResetState {
  final int deletedCount;
  const ResetSuccess({
    required super.selectedTypes,
    required this.deletedCount,
  });
}

final class ResetFailure extends ResetState {
  final String errorMessage;
  const ResetFailure({
    required super.selectedTypes,
    required this.errorMessage,
  });
}
