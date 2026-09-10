import 'package:money_flow/core/services/hive_service.dart';

enum BackupType {
  transactions,
  categories,
  budgets,
  recurringTransactions,
  userProfile,
}

extension BackupTypeExtension on BackupType {
  String get title {
    switch (this) {
      case BackupType.transactions:
        return 'Transactions';
      case BackupType.categories:
        return 'Categories';
      case BackupType.budgets:
        return 'Budgets';
      case BackupType.recurringTransactions:
        return 'Recurring Transactions';
      case BackupType.userProfile:
        return 'Profile & Settings';
    }
  }

  int get count {
    switch (this) {
      case BackupType.transactions:
        return HiveService.instance.getTransactions().length;
      case BackupType.categories:
        return HiveService.instance.getCategories().length;
      case BackupType.budgets:
        return HiveService.instance.getBudgets().length;
      case BackupType.recurringTransactions:
        return HiveService.instance.getRecurringTransactions().length;
      case BackupType.userProfile:
        return HiveService.getUserModel() != null ? 1 : 0;
    }
  }

  String get keyName {
    switch (this) {
      case BackupType.transactions:
        return 'transactions';
      case BackupType.categories:
        return 'categories';
      case BackupType.budgets:
        return 'budgets';
      case BackupType.recurringTransactions:
        return 'recurring_transactions';
      case BackupType.userProfile:
        return 'user_profile';
    }
  }
}
