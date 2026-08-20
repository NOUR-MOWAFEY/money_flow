part of 'reports_cubit.dart';

@immutable
abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsSuccess extends ReportsState {
  ReportsSuccess({
    required this.selectedPeriod,
    required this.barData,
    required this.pieItems,
  });

  final ReportPeriod selectedPeriod;
  final List<IncomeExpenseBarData> barData;
  final List<PieChartItem> pieItems;
}

class ReportsFailure extends ReportsState {
  ReportsFailure(this.message);

  final String message;
}
