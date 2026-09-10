import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/data_management/data/models/backup_type.dart';

class ResetService {
  const ResetService();

  int getCountForType(BackupType type) => type.count;

  int getTotalCountForTypes(Set<BackupType> types) {
    int total = 0;
    for (final type in types) {
      total += getCountForType(type);
    }
    return total;
  }

  Future<void> resetData(Set<BackupType> selectedTypes) async {
    if (selectedTypes.isEmpty) {
      throw Exception('No items selected for reset.');
    }

    if (selectedTypes.contains(BackupType.transactions)) {
      await HiveService.instance.reset();
    }

    if (selectedTypes.contains(BackupType.categories)) {
      await HiveService.instance.clearCategories();
    }

    if (selectedTypes.contains(BackupType.budgets)) {
      await HiveService.instance.clearBudgets();
    }

    if (selectedTypes.contains(BackupType.recurringTransactions)) {
      await HiveService.instance.clearRecurringTransactions();
    }

    if (selectedTypes.contains(BackupType.userProfile)) {
      await HiveService.deleteUserModel();
    }
  }
}
