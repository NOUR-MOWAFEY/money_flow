import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/features/data_management/data/models/backup_payload.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';
import 'package:money_flow/features/data_management/data/services/restore_service.dart';
import 'package:money_flow/features/data_management/view_model/restore_cubit/restore_cubit.dart';

class FakeRestoreService extends RestoreService {
  PickedBackupFile? fileToPick;
  bool shouldFailRestore = false;
  BackupDataPayload? lastRestoredPayload;
  Set<BackupType>? lastRestoredTypes;
  RestoreMode? lastRestoredMode;

  @override
  Future<PickedBackupFile?> pickBackupFile() async {
    return fileToPick;
  }

  @override
  Future<void> restoreData({
    required BackupDataPayload payload,
    required Set<BackupType> selectedTypes,
    required RestoreMode mode,
  }) async {
    if (shouldFailRestore) {
      throw Exception('Simulated restore failure');
    }
    lastRestoredPayload = payload;
    lastRestoredTypes = selectedTypes;
    lastRestoredMode = mode;
  }
}

String createSampleBackupJson({
  String appName = 'Money Flow',
  bool includeTransactions = true,
  bool includeCategories = true,
}) {
  final data = <String, dynamic>{};
  if (includeTransactions) {
    data['transactions'] = [
      {
        'title': 'Groceries',
        'amount': 150.0,
        'date': '2026-09-01T10:00:00.000',
        'isExpense': true,
      },
      {
        'title': 'Salary',
        'amount': 5000.0,
        'date': '2026-09-01T08:00:00.000',
        'isExpense': false,
      },
    ];
  }
  if (includeCategories) {
    data['categories'] = [
      {
        'title': 'Food',
        'iconCodePoint': 58000,
        'iconFontFamily': 'MaterialIcons',
        'iconFontPackage': null,
        'color': 4280391411,
        'categoryType': 'expenses',
      }
    ];
  }

  return jsonEncode({
    'appName': appName,
    'version': 1,
    'exportDate': '2026-09-10T12:00:00.000',
    'selectedTypes': data.keys.toList(),
    'data': data,
  });
}

void main() {
  late FakeRestoreService fakeService;
  late RestoreCubit cubit;

  setUp(() {
    fakeService = FakeRestoreService();
    cubit = RestoreCubit(restoreService: fakeService);
  });

  tearDown(() {
    cubit.close();
  });

  test('Initial state is RestoreInitial', () {
    expect(cubit.state, isA<RestoreInitial>());
  });

  test('pickFile when cancelled returns to RestoreInitial', () async {
    fakeService.fileToPick = null;
    await cubit.pickFile();
    expect(cubit.state, isA<RestoreInitial>());
  });

  test('loadJsonContent with invalid JSON emits RestoreFailure', () {
    cubit.loadJsonContent('this is not json');
    expect(cubit.state, isA<RestoreFailure>());
    final state = cubit.state as RestoreFailure;
    expect(state.errorMessage.contains('valid JSON'), true);
  });

  test('loadJsonContent with foreign app backup emits RestoreFailure', () {
    final foreignJson = createSampleBackupJson(appName: 'OtherApp');
    cubit.loadJsonContent(foreignJson);
    expect(cubit.state, isA<RestoreFailure>());
    final state = cubit.state as RestoreFailure;
    expect(state.errorMessage.contains('Money Flow'), true);
  });

  test('loadJsonContent with empty data emits RestoreFailure', () {
    final emptyJson = jsonEncode({
      'appName': 'Money Flow',
      'version': 1,
      'data': {},
    });
    cubit.loadJsonContent(emptyJson);
    expect(cubit.state, isA<RestoreFailure>());
    final state = cubit.state as RestoreFailure;
    expect(state.errorMessage.contains('does not contain any restorable data'), true);
  });

  test('loadJsonContent with valid JSON emits RestoreFileLoaded with all available types selected', () {
    final jsonStr = createSampleBackupJson();
    cubit.loadJsonContent(jsonStr, fileName: 'test_backup.json');

    expect(cubit.state, isA<RestoreFileLoaded>());
    final state = cubit.state as RestoreFileLoaded;
    expect(state.payload.fileName, 'test_backup.json');
    expect(state.payload.transactions.length, 2);
    expect(state.payload.categories.length, 1);
    expect(state.payload.availableTypes.contains(BackupType.transactions), true);
    expect(state.payload.availableTypes.contains(BackupType.categories), true);
    expect(state.allSelected, true);
    expect(state.mode, RestoreMode.merge);
  });

  test('toggleItem modifies selectedTypes correctly', () {
    cubit.loadJsonContent(createSampleBackupJson());
    expect(cubit.state, isA<RestoreFileLoaded>());

    cubit.toggleItem(BackupType.transactions, false);
    var state = cubit.state as RestoreFileLoaded;
    expect(state.isSelected(BackupType.transactions), false);
    expect(state.isSelected(BackupType.categories), true);
    expect(state.allSelected, false);

    cubit.toggleItem(BackupType.transactions, true);
    state = cubit.state as RestoreFileLoaded;
    expect(state.isSelected(BackupType.transactions), true);
    expect(state.allSelected, true);
  });

  test('toggleSelectAll toggles all on/off', () {
    cubit.loadJsonContent(createSampleBackupJson());
    var state = cubit.state as RestoreFileLoaded;
    expect(state.allSelected, true);

    cubit.toggleSelectAll(false);
    state = cubit.state as RestoreFileLoaded;
    expect(state.noneSelected, true);
    expect(state.selectedTypes.isEmpty, true);

    cubit.toggleSelectAll(true);
    state = cubit.state as RestoreFileLoaded;
    expect(state.allSelected, true);
  });

  test('setRestoreMode switches between merge and replace', () {
    cubit.loadJsonContent(createSampleBackupJson());
    cubit.setRestoreMode(RestoreMode.replace);

    final state = cubit.state as RestoreFileLoaded;
    expect(state.mode, RestoreMode.replace);
  });

  test('restoreSelectedData with empty selection emits RestoreFailure', () async {
    cubit.loadJsonContent(createSampleBackupJson());
    cubit.toggleSelectAll(false);

    await cubit.restoreSelectedData();
    expect(cubit.state, isA<RestoreFailure>());
    final failure = cubit.state as RestoreFailure;
    expect(failure.errorMessage.contains('at least one item'), true);
  });

  test('restoreSelectedData successfully calls service and emits RestoreSuccess', () async {
    cubit.loadJsonContent(createSampleBackupJson());
    cubit.setRestoreMode(RestoreMode.replace);

    await cubit.restoreSelectedData();

    expect(cubit.state, isA<RestoreSuccess>());
    final success = cubit.state as RestoreSuccess;
    // 2 transactions + 1 category = 3
    expect(success.restoredCount, 3);
    expect(success.mode, RestoreMode.replace);
    expect(fakeService.lastRestoredMode, RestoreMode.replace);
    expect(fakeService.lastRestoredTypes?.length, 2);
  });

  test('restoreSelectedData emits RestoreFailure when service fails', () async {
    fakeService.shouldFailRestore = true;
    cubit.loadJsonContent(createSampleBackupJson());

    await cubit.restoreSelectedData();

    expect(cubit.state, isA<RestoreFailure>());
    final failure = cubit.state as RestoreFailure;
    expect(failure.errorMessage, 'Simulated restore failure');
    expect(failure.payload != null, true);
  });

  test('clearFile resets state to RestoreInitial', () {
    cubit.loadJsonContent(createSampleBackupJson());
    expect(cubit.state, isA<RestoreFileLoaded>());

    cubit.clearFile();
    expect(cubit.state, isA<RestoreInitial>());
  });

  test('parseBackupJson preserves transaction id when present and auto-assigns when absent', () {
    final service = const RestoreService();
    final jsonWithId = jsonEncode({
      'appName': 'Money Flow',
      'version': 1,
      'data': {
        'transactions': [
          {
            'id': 'tx_12345',
            'title': 'Coffee',
            'amount': 4.5,
            'date': '2026-09-10T08:00:00.000',
            'isExpense': true,
          },
          {
            'title': 'Lunch',
            'amount': 15.0,
            'date': '2026-09-10T12:30:00.000',
            'isExpense': true,
          }
        ]
      }
    });

    final payload = service.parseBackupJson(jsonWithId);
    expect(payload.transactions.length, 2);
    expect(payload.transactions[0].id, 'tx_12345');
    expect(payload.transactions[1].id.isNotEmpty, true);
  });
}
