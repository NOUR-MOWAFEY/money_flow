import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/services/backup_service.dart';
import 'package:money_flow/features/data_management/view_model/backup_cubit/backup_cubit.dart';

class FakeBackupService extends BackupService {
  Set<BackupType>? lastExportedTypes;
  bool shouldFail = false;
  String? saveReturnValue = '/fake/path/saved_backup.json';

  @override
  Future<File> createBackupFile(Set<BackupType> selectedTypes) async {
    if (shouldFail) {
      throw Exception('Simulated backup error');
    }
    lastExportedTypes = selectedTypes;
    return File('/fake/path/backup.json');
  }

  @override
  Future<void> shareBackup(Set<BackupType> selectedTypes) async {
    if (shouldFail) {
      throw Exception('Simulated export error');
    }
    lastExportedTypes = selectedTypes;
  }

  @override
  Future<String?> saveBackupToDevice(Set<BackupType> selectedTypes) async {
    if (shouldFail) {
      throw Exception('Simulated save error');
    }
    lastExportedTypes = selectedTypes;
    return saveReturnValue;
  }
}

void main() {
  late FakeBackupService fakeBackupService;
  late BackupCubit cubit;

  setUp(() {
    fakeBackupService = FakeBackupService();
    cubit = BackupCubit(backupService: fakeBackupService);
  });

  tearDown(() {
    cubit.close();
  });

  test('Initial state selects all backup types', () {
    expect(cubit.state.selectedTypes.length, BackupType.values.length);
    expect(cubit.allSelected, true);
    expect(cubit.noneSelected, false);
    expect(cubit.selectAllValue, true);
  });

  test('toggleItem removes and re-adds a type', () {
    cubit.toggleItem(BackupType.transactions, false);
    expect(cubit.isSelected(BackupType.transactions), false);
    expect(cubit.allSelected, false);
    expect(cubit.selectAllValue, null);

    cubit.toggleItem(BackupType.transactions, true);
    expect(cubit.isSelected(BackupType.transactions), true);
    expect(cubit.allSelected, true);
  });

  test('toggleSelectAll toggles all off and all on', () {
    cubit.toggleSelectAll(false);
    expect(cubit.noneSelected, true);
    expect(cubit.state.selectedTypes.isEmpty, true);
    expect(cubit.selectAllValue, false);

    cubit.toggleSelectAll(true);
    expect(cubit.allSelected, true);
    expect(cubit.state.selectedTypes.length, BackupType.values.length);
    expect(cubit.selectAllValue, true);
  });

  test('shareBackup with empty selection emits failure', () async {
    cubit.toggleSelectAll(false);
    await cubit.shareBackup();

    expect(cubit.state, isA<BackupExportFailure>());
    final failureState = cubit.state as BackupExportFailure;
    expect(
      failureState.errorMessage,
      'Please select at least one item to back up.',
    );
  });

  test('shareBackup with selected items emits success', () async {
    cubit.toggleItem(BackupType.budgets, false);
    await cubit.shareBackup();

    expect(cubit.state, isA<BackupExportSuccess>());
    expect(
      fakeBackupService.lastExportedTypes?.contains(BackupType.budgets),
      false,
    );
    expect(
      fakeBackupService.lastExportedTypes
          ?.contains(BackupType.transactions),
      true,
    );
  });

  test('shareBackup when service fails emits failure', () async {
    fakeBackupService.shouldFail = true;
    await cubit.shareBackup();

    expect(cubit.state, isA<BackupExportFailure>());
  });

  test('saveToDevice with selected items emits BackupSaveSuccess', () async {
    await cubit.saveToDevice();

    expect(cubit.state, isA<BackupSaveSuccess>());
    final successState = cubit.state as BackupSaveSuccess;
    expect(successState.filePath, '/fake/path/saved_backup.json');
  });

  test('saveToDevice when cancelled emits BackupSelectionChanged', () async {
    fakeBackupService.saveReturnValue = null;
    await cubit.saveToDevice();

    expect(cubit.state, isA<BackupSelectionChanged>());
  });

  test('saveToDevice when service fails emits failure', () async {
    fakeBackupService.shouldFail = true;
    await cubit.saveToDevice();

    expect(cubit.state, isA<BackupExportFailure>());
  });
}
