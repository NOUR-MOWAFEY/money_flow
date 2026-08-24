import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_toggle_switch.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';

class BudgetPeriodToggle extends StatelessWidget {
  const BudgetPeriodToggle({
    super.key,
    required this.onChange,
    this.selectedPeriod,
  });

  final ValueChanged<BudgetPeriod> onChange;
  final BudgetPeriod? selectedPeriod;

  @override
  Widget build(BuildContext context) {
    return CustomToggleSwitch<BudgetPeriod>(
      current: selectedPeriod,
      values: BudgetPeriod.values,
      itemLabelBuilder: (period) => period.title,
      onChanged: onChange,
    );
  }
}
