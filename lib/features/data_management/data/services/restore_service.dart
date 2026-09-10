import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/data_management/data/models/backup_payload.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';
import 'package:money_flow/features/data_management/data/services/backup_data_serializer.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class RestoreService {
  const RestoreService();

  Future<PickedBackupFile?> pickBackupFile() async {
    final picked = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (picked == null) return null;

    final content = await picked.xFile.readAsString();

    return PickedBackupFile(
      content: content,
      fileName: picked.name,
      sizeBytes: picked.lengthSync(),
    );
  }

  BackupDataPayload parseBackupJson(String jsonString, {String? fileName}) {
    dynamic decoded;
    try {
      decoded = jsonDecode(jsonString);
    } catch (e) {
      throw const FormatException('Selected file is not valid JSON.');
    }

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid backup structure.');
    }

    final appName = decoded['appName'] as String?;
    if (appName == null || appName != 'Money Flow') {
      throw const FormatException(
        'This file is not a valid Money Flow backup file.',
      );
    }

    final version = (decoded['version'] as num?)?.toInt() ?? 1;
    final exportDateStr = decoded['exportDate'] as String?;
    final exportDate =
        exportDateStr != null ? DateTime.tryParse(exportDateStr) : null;

    final data = decoded['data'] as Map<String, dynamic>? ?? {};

    final availableTypes = <BackupType>{};
    final itemCounts = <BackupType, int>{};

    // Parse Transactions
    final transactionsList = <TransactionModel>[];
    if (data.containsKey(BackupType.transactions.keyName)) {
      final rawList = data[BackupType.transactions.keyName];
      if (rawList is List) {
        for (final item in rawList) {
          if (item is Map<String, dynamic>) {
            transactionsList.add(BackupDataSerializer.transactionFromJson(item));
          }
        }
        availableTypes.add(BackupType.transactions);
        itemCounts[BackupType.transactions] = transactionsList.length;
      }
    }

    // Parse Categories
    final categoriesList = <CategoryModel>[];
    if (data.containsKey(BackupType.categories.keyName)) {
      final rawList = data[BackupType.categories.keyName];
      if (rawList is List) {
        for (final item in rawList) {
          if (item is Map<String, dynamic>) {
            categoriesList.add(BackupDataSerializer.categoryFromJson(item));
          }
        }
        availableTypes.add(BackupType.categories);
        itemCounts[BackupType.categories] = categoriesList.length;
      }
    }

    // Parse Budgets
    final budgetsList = <BudgetModel>[];
    if (data.containsKey(BackupType.budgets.keyName)) {
      final rawList = data[BackupType.budgets.keyName];
      if (rawList is List) {
        for (final item in rawList) {
          if (item is Map<String, dynamic>) {
            budgetsList.add(BackupDataSerializer.budgetFromJson(item));
          }
        }
        availableTypes.add(BackupType.budgets);
        itemCounts[BackupType.budgets] = budgetsList.length;
      }
    }

    // Parse Recurring Transactions
    final recurringList = <RecurringTransactionModel>[];
    if (data.containsKey(BackupType.recurringTransactions.keyName)) {
      final rawList = data[BackupType.recurringTransactions.keyName];
      if (rawList is List) {
        for (final item in rawList) {
          if (item is Map<String, dynamic>) {
            recurringList.add(BackupDataSerializer.recurringFromJson(item));
          }
        }
        availableTypes.add(BackupType.recurringTransactions);
        itemCounts[BackupType.recurringTransactions] = recurringList.length;
      }
    }

    // Parse User Profile
    UserModel? userProfile;
    if (data.containsKey(BackupType.userProfile.keyName)) {
      final rawUser = data[BackupType.userProfile.keyName];
      if (rawUser is Map<String, dynamic>) {
        userProfile = BackupDataSerializer.userFromJson(rawUser);
        availableTypes.add(BackupType.userProfile);
        itemCounts[BackupType.userProfile] = 1;
      }
    }

    return BackupDataPayload(
      appName: appName,
      version: version,
      exportDate: exportDate,
      availableTypes: availableTypes,
      itemCounts: itemCounts,
      transactions: transactionsList,
      categories: categoriesList,
      budgets: budgetsList,
      recurringTransactions: recurringList,
      userProfile: userProfile,
      fileName: fileName,
    );
  }

  Future<void> restoreData({
    required BackupDataPayload payload,
    required Set<BackupType> selectedTypes,
    required RestoreMode mode,
  }) async {
    if (selectedTypes.isEmpty) {
      throw Exception('Please select at least one item type to restore.');
    }

    // 1. Categories
    if (selectedTypes.contains(BackupType.categories) &&
        payload.categories.isNotEmpty) {
      if (mode == RestoreMode.replace) {
        await HiveService.instance.clearCategories();
        await HiveService.instance.addCategories(payload.categories);
      } else {
        final existingCategories = HiveService.instance.getCategories();
        final toAdd = payload.categories.where((cat) {
          return !existingCategories.any(
            (e) =>
                e.title.toLowerCase() == cat.title.toLowerCase() &&
                e.categoryType == cat.categoryType,
          );
        }).toList();
        if (toAdd.isNotEmpty) {
          await HiveService.instance.addCategories(toAdd);
        }
      }
    }

    // 2. Transactions
    if (selectedTypes.contains(BackupType.transactions) &&
        payload.transactions.isNotEmpty) {
      if (mode == RestoreMode.replace) {
        await HiveService.instance.reset();
        await HiveService.instance.addTransactions(payload.transactions);
      } else {
        final existingTransactions = HiveService.instance.getTransactions();
        final toAdd = payload.transactions.where((t) {
          return !existingTransactions.any((e) {
            if (t.id.isNotEmpty && e.id.isNotEmpty && t.id == e.id) {
              return true;
            }
            return e.title == t.title &&
                e.amount == t.amount &&
                e.isExpense == t.isExpense &&
                e.date.isAtSameMomentAs(t.date);
          });
        }).toList();

        if (toAdd.isNotEmpty) {
          await HiveService.instance.addTransactions(toAdd);
        }
      }
    }

    // 3. Budgets
    if (selectedTypes.contains(BackupType.budgets) &&
        payload.budgets.isNotEmpty) {
      if (mode == RestoreMode.replace) {
        await HiveService.instance.clearBudgets();
        await HiveService.instance.addBudgets(payload.budgets);
      } else {
        final existingBudgets = HiveService.instance.getBudgets();
        final toAdd = payload.budgets.where((b) {
          return !existingBudgets.any(
            (e) =>
                e.categoryTitle.toLowerCase() ==
                    b.categoryTitle.toLowerCase() &&
                e.period == b.period,
          );
        }).toList();
        if (toAdd.isNotEmpty) {
          await HiveService.instance.addBudgets(toAdd);
        }
      }
    }

    // 4. Recurring Transactions
    if (selectedTypes.contains(BackupType.recurringTransactions) &&
        payload.recurringTransactions.isNotEmpty) {
      if (mode == RestoreMode.replace) {
        await HiveService.instance.clearRecurringTransactions();
        await HiveService.instance.addRecurringTransactions(
          payload.recurringTransactions,
        );
      } else {
        final existing = HiveService.instance.getRecurringTransactions();
        final toAdd = payload.recurringTransactions.where((r) {
          return !existing.any((e) => e.id == r.id);
        }).toList();
        if (toAdd.isNotEmpty) {
          await HiveService.instance.addRecurringTransactions(toAdd);
        }
      }
    }

    // 5. User Profile
    if (selectedTypes.contains(BackupType.userProfile) &&
        payload.userProfile != null) {
      await HiveService.saveUserModel(payload.userProfile!);
    }
  }
}
