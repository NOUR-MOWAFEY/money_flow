import 'package:hive/hive.dart';

part 'environment_expense_model.g.dart';

@HiveType(typeId: 12)
class EnvironmentExpenseModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String environmentId;

  @HiveField(2)
  String title;

  @HiveField(3)
  double amount;

  @HiveField(4)
  DateTime date;

  EnvironmentExpenseModel({
    required this.id,
    required this.environmentId,
    required this.title,
    required this.amount,
    required this.date,
  });
}
