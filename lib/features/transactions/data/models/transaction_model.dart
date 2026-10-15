import 'package:hive/hive.dart';
import 'package:money_flow/core/services/hive_service.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool isExpense;

  @HiveField(4)
  String id;

  @HiveField(5)
  String? environmentId;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.isExpense,
    String? id,
    this.environmentId,
  }) : id = id ??
            '${DateTime.now().microsecondsSinceEpoch}_${title.hashCode}';

  bool get isEnvironmentLinked =>
      (environmentId != null && environmentId!.isNotEmpty) ||
      title.startsWith('Environment: ') ||
      title.startsWith('Top-up: ') ||
      title.startsWith('Remaining from ') ||
      title.startsWith('Remaining of ');

  String? get extractedEnvironmentName {
    if (title.startsWith('Environment: ')) {
      return title.substring('Environment: '.length).trim();
    }
    if (title.startsWith('Top-up: ')) {
      return title.substring('Top-up: '.length).trim();
    }
    if (title.startsWith('Remaining from ')) {
      return title.substring('Remaining from '.length).trim();
    }
    if (title.startsWith('Remaining of ')) {
      return title.substring('Remaining of '.length).trim();
    }
    return null;
  }

  /// Checks whether this transaction is currently linked to an active, existing environment.
  /// If the environment was deleted, returns false so that the user can delete or edit
  /// the transaction in the main ledger.
  bool isEnvironmentActive([HiveService? service]) {
    if (!isEnvironmentLinked) return false;
    final hive = service ?? HiveService.instance;
    return hive.isTransactionEnvironmentActive(this);
  }
}
