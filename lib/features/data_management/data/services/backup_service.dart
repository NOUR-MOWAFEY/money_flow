import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/data_management/data/models/backup_payload.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';
import 'package:money_flow/features/data_management/data/services/backup_data_serializer.dart';
import 'package:money_flow/features/data_management/data/services/restore_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  final RestoreService _restoreService;

  const BackupService({RestoreService restoreService = const RestoreService()})
      : _restoreService = restoreService;

  String generateBackupJson(Set<BackupType> selectedTypes) {
    if (selectedTypes.isEmpty) {
      throw Exception('No data selected for backup');
    }

    final backupPayload = <String, dynamic>{
      'appName': 'Money Flow',
      'version': 1,
      'exportDate': DateTime.now().toIso8601String(),
      'selectedTypes': selectedTypes.map((e) => e.keyName).toList(),
      'data': <String, dynamic>{},
    };

    final dataMap = backupPayload['data'] as Map<String, dynamic>;

    if (selectedTypes.contains(BackupType.transactions)) {
      final transactions = HiveService.instance.getTransactions();
      dataMap[BackupType.transactions.keyName] =
          transactions.map(BackupDataSerializer.transactionToJson).toList();
    }

    if (selectedTypes.contains(BackupType.categories)) {
      final categories = HiveService.instance.getCategories();
      dataMap[BackupType.categories.keyName] =
          categories.map(BackupDataSerializer.categoryToJson).toList();
    }

    if (selectedTypes.contains(BackupType.budgets)) {
      final budgets = HiveService.instance.getBudgets();
      dataMap[BackupType.budgets.keyName] =
          budgets.map(BackupDataSerializer.budgetToJson).toList();
    }

    if (selectedTypes.contains(BackupType.recurringTransactions)) {
      final recurring = HiveService.instance.getRecurringTransactions();
      dataMap[BackupType.recurringTransactions.keyName] =
          recurring.map(BackupDataSerializer.recurringToJson).toList();
    }

    if (selectedTypes.contains(BackupType.userProfile)) {
      final user = HiveService.getUserModel();
      if (user != null) {
        dataMap[BackupType.userProfile.keyName] =
            BackupDataSerializer.userToJson(user);
      }
    }

    return const JsonEncoder.withIndent('  ').convert(backupPayload);
  }

  Future<File> createBackupFile(Set<BackupType> selectedTypes) async {
    final jsonString = generateBackupJson(selectedTypes);

    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${dir.path}/money_flow_backup_$timestamp.json');
    await file.writeAsString(jsonString);

    return file;
  }

  Future<String?> saveBackupToDevice(Set<BackupType> selectedTypes) async {
    final jsonString = generateBackupJson(selectedTypes);
    final bytes = Uint8List.fromList(utf8.encode(jsonString));
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'money_flow_backup_$timestamp.json';

    final uri = await FilePicker.saveFile(
      dialogTitle: 'Save Backup File',
      fileName: fileName,
      bytes: bytes,
      mimeType: 'application/json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (uri == null) return null;
    return uri.hasScheme && uri.isScheme('file')
        ? uri.toFilePath()
        : uri.toString();
  }

  Future<void> shareBackup(Set<BackupType> selectedTypes) async {
    final file = await createBackupFile(selectedTypes);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json')],
        text:
            'Money Flow Backup (${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())})',
      ),
    );
  }

  // Restore delegations for backwards compatibility
  Future<PickedBackupFile?> pickBackupFile() =>
      _restoreService.pickBackupFile();

  BackupDataPayload parseBackupJson(String jsonString, {String? fileName}) =>
      _restoreService.parseBackupJson(jsonString, fileName: fileName);

  Future<void> restoreData({
    required BackupDataPayload payload,
    required Set<BackupType> selectedTypes,
    required RestoreMode mode,
  }) =>
      _restoreService.restoreData(
        payload: payload,
        selectedTypes: selectedTypes,
        mode: mode,
      );
}
