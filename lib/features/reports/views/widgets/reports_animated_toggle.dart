import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
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
    return AnimatedToggleSwitch<ReportPeriod>.size(
      current: selectedPeriod,
      values: ReportPeriod.values,
      iconList: ReportPeriod.values.map((period) {
        return CustomText(period.title, style: _customTextStyle(period));
      }).toList(),
      indicatorSize: const Size.fromWidth(140),
      borderWidth: 4.0,
      selectedIconScale: 1.15,
      onChanged: onChange,
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
      color: selectedPeriod == period ? Colors.white : Colors.black54,
    );
  }
}
