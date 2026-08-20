import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';
import 'package:money_flow/features/budget/view_models/budget_cubit/budget_cubit.dart';
import 'package:money_flow/features/reports/view_models/reports_cubit/reports_cubit.dart';
import 'package:money_flow/features/reports/views/widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReportsCubit(HiveService())..loadReports(),
        ),
        BlocProvider(
          create: (context) =>
              BudgetCubit(HiveService(), period: BudgetPeriod.weekly)
                ..loadBudgets(),
        ),
      ],
      child: const Scaffold(body: SafeArea(child: ReportsViewBody())),
    );
  }
}
