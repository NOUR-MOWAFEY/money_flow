import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/reports/view_models/reports_cubit/reports_cubit.dart';
import 'package:money_flow/features/reports/views/widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsCubit(HiveService())..loadReports(),
      child: const Scaffold(body: SafeArea(child: ReportsViewBody())),
    );
  }
}
