import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';

class ReportsAnimatedToggle extends StatelessWidget {
  const ReportsAnimatedToggle({
    super.key,
    required this.selectedPeriod,
    required this.onChange,
  });

  final ReportPeriod selectedPeriod;
  final void Function(ReportPeriod period) onChange;

  @override
  Widget build(BuildContext context) {
    return CustomToggleSwitch<ReportPeriod>(
      current: selectedPeriod,
      values: ReportPeriod.values,
      itemLabelBuilder: (period) => period.title,

      onChanged: onChange,
    );
  }
}
