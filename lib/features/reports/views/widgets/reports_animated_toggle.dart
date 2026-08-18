import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/reports/data/models/report_period.dart';

class ReportsAnimatedToggle extends StatefulWidget {
  const ReportsAnimatedToggle({
    super.key,
    required this.onChange,
    this.initialPeriod,
  });

  final void Function(ReportPeriod period) onChange;
  final ReportPeriod? initialPeriod;

  @override
  State<ReportsAnimatedToggle> createState() => _ReportsAnimatedToggleState();
}

class _ReportsAnimatedToggleState extends State<ReportsAnimatedToggle> {
  late ReportPeriod value;

  @override
  void initState() {
    value = widget.initialPeriod ?? ReportPeriod.week;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<ReportPeriod>.size(
      current: value,
      values: ReportPeriod.values,
      iconList: ReportPeriod.values.map((period) {
        return CustomText(period.title, style: _customTextStyle(period));
      }).toList(),
      indicatorSize: const Size.fromWidth(140),
      borderWidth: 4.0,
      selectedIconScale: 1.15,
      onChanged: (val) {
        widget.onChange(val);
        setState(() => value = val);
      },
      style: ToggleStyle(
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        indicatorColor: AppColors.primary,
        backgroundColor: AppColors.secondaryColor,
        boxShadow: const [],
      ),
    );
  }

  TextStyle _customTextStyle(ReportPeriod period) {
    return TextStyle(
      fontSize: 14,
      color: value == period ? Colors.white : Colors.black54,
    );
  }
}
