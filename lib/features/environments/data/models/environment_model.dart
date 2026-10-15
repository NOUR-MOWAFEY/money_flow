import 'package:hive/hive.dart';

part 'environment_model.g.dart';

@HiveType(typeId: 11)
class EnvironmentModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double initialAmount;

  @HiveField(4)
  double currentBalance;

  @HiveField(5)
  bool isClosed;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  int colorValue;

  @HiveField(8)
  int iconCodePoint;

  @HiveField(9)
  bool deductedFromMain;

  EnvironmentModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.initialAmount,
    required this.currentBalance,
    this.isClosed = false,
    required this.createdAt,
    this.colorValue = 0xFF0B6098,
    this.iconCodePoint = 0xe3ae,
    this.deductedFromMain = true,
  });

  double get spentAmount => (initialAmount - currentBalance).clamp(0, double.infinity);

  double get progress {
    if (initialAmount <= 0) return 0;
    return (currentBalance / initialAmount).clamp(0.0, 1.0);
  }
}
