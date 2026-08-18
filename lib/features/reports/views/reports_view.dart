import 'package:flutter/material.dart';
import 'package:money_flow/features/reports/views/widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ReportsViewBody()));
  }
}
