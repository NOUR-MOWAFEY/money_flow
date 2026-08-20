import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/reports/data/models/income_expense_bar_data.dart';
import 'package:money_flow/features/reports/data/models/pie_chart_item.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';
import 'package:money_flow/features/reports/data/reports_data_helper.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.hiveService) : super(ReportsInitial()) {
    _transactionsSubscription = hiveService.watchTransactions().listen((_) {
      _reload();
    });
    loadReports();
  }

  final HiveService hiveService;
  StreamSubscription? _transactionsSubscription;
  ReportPeriod _selectedPeriod = ReportPeriod.weekly;

  ReportPeriod get selectedPeriod => _selectedPeriod;

  void loadReports() {
    emit(ReportsLoading());
    _reload();
  }

  void changePeriod(ReportPeriod period) {
    _selectedPeriod = period;
    emit(ReportsLoading());
    _reload();
  }

  void _reload() {
    try {
      final transactions = hiveService.getTransactions();
      final barData = ReportsDataHelper.buildBarChartData(
        transactions,
        _selectedPeriod,
      );
      final pieItems = ReportsDataHelper.buildPieChartData(
        transactions,
        _selectedPeriod,
      );

      emit(
        ReportsSuccess(
          selectedPeriod: _selectedPeriod,
          barData: barData,
          pieItems: pieItems,
        ),
      );
    } catch (_) {
      emit(ReportsFailure('Failed to load reports, Please try again'));
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription?.cancel();
    return super.close();
  }
}
