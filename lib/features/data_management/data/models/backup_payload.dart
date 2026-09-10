import 'package:money_flow/features/data_management/data/models/backup_type.dart';
import 'package:money_flow/features/budget/data/models/budget_model.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/settings/data/models/recurring_transaction_model.dart';
import 'package:money_flow/features/settings/data/models/user_model.dart';
import 'package:money_flow/features/transactions/data/models/transaction_model.dart';

class PickedBackupFile {
  final String content;
  final String fileName;
  final int? sizeBytes;

  const PickedBackupFile({
    required this.content,
    required this.fileName,
    this.sizeBytes,
  });
}

class BackupDataPayload {
  final String appName;
  final int version;
  final DateTime? exportDate;
  final Set<BackupType> availableTypes;
  final Map<BackupType, int> itemCounts;
  final List<TransactionModel> transactions;
  final List<CategoryModel> categories;
  final List<BudgetModel> budgets;
  final List<RecurringTransactionModel> recurringTransactions;
  final UserModel? userProfile;
  final String? fileName;

  const BackupDataPayload({
    required this.appName,
    required this.version,
    this.exportDate,
    required this.availableTypes,
    required this.itemCounts,
    this.transactions = const [],
    this.categories = const [],
    this.budgets = const [],
    this.recurringTransactions = const [],
    this.userProfile,
    this.fileName,
  });

  int get totalItemsCount {
    return transactions.length +
        categories.length +
        budgets.length +
        recurringTransactions.length +
        (userProfile != null ? 1 : 0);
  }

  int countFor(BackupType type) => itemCounts[type] ?? 0;
}
