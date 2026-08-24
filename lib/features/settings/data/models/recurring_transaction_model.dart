import 'package:hive/hive.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

part 'recurring_transaction_model.g.dart';

@HiveType(typeId: 8)
class RecurringTransactionModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  CategoryType type;

  @HiveField(4)
  RecurrenceFrequency frequency;

  @HiveField(5)
  DateTime startDate;

  @HiveField(6)
  DateTime? endDate;

  @HiveField(7)
  bool isActive;

  @HiveField(8)
  String? categoryTitle;

  @HiveField(9)
  DateTime? nextOccurrence;

  @HiveField(10)
  String? note;

  RecurringTransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.frequency,
    required this.startDate,
    this.endDate,
    this.categoryTitle,
    this.nextOccurrence,
    this.note,
    this.isActive = true,
  });
}

@HiveType(typeId: 9)
enum RecurrenceFrequency {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,
}
