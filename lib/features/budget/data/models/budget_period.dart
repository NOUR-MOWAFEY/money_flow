import 'package:hive/hive.dart';

part 'budget_period.g.dart';

@HiveType(typeId: 7)
enum BudgetPeriod {
  @HiveField(0)
  weekly('Weekly'),
  @HiveField(1)
  monthly('Monthly');

  const BudgetPeriod(this.title);
  final String title;
}
