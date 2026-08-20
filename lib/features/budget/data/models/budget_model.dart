import 'package:hive/hive.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 6)
class BudgetModel extends HiveObject {
  @HiveField(0)
  String categoryTitle;

  @HiveField(1)
  double limitAmount;

  @HiveField(2)
  BudgetPeriod period;

  BudgetModel({
    required this.categoryTitle,
    required this.limitAmount,
    required this.period,
  });
}
