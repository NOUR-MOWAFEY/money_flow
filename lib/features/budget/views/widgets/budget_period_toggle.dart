import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/budget/data/models/budget_period.dart';

class BudgetPeriodToggle extends StatefulWidget {
  const BudgetPeriodToggle({
    super.key,
    required this.onChange,
    this.selectedPeriod,
  });

  final ValueChanged<BudgetPeriod> onChange;
  final BudgetPeriod? selectedPeriod;

  @override
  State<BudgetPeriodToggle> createState() => _BudgetPeriodToggleState();
}

class _BudgetPeriodToggleState extends State<BudgetPeriodToggle> {
  late BudgetPeriod value;

  @override
  void initState() {
    value = widget.selectedPeriod ?? BudgetPeriod.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<BudgetPeriod>.size(
      current: value,
      values: BudgetPeriod.values,

      iconList: BudgetPeriod.values.map((period) {
        return CustomText(period.title, style: _customTextStyle(period));
      }).toList(),

      indicatorSize: const Size.fromWidth(170),
      borderWidth: 4.0,
      selectedIconScale: 1.15,

      onChanged: (value) {
        widget.onChange(value);
        setState(() => this.value = value);
      },

      style: ToggleStyle(
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        indicatorColor: AppColors.primary,
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }

  TextStyle _customTextStyle(BudgetPeriod period) {
    return TextStyle(
      fontSize: 14,
      color: value == period ? Colors.white : Colors.black54,
    );
  }
}
