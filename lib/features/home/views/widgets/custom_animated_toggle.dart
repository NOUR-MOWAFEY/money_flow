import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class CustomAnimatedToggle extends StatefulWidget {
  const CustomAnimatedToggle({
    super.key,
    required this.onChange,
    this.transactionType,
  });

  final void Function(CategoryType transactionType) onChange;
  final CategoryType? transactionType;

  @override
  State<CustomAnimatedToggle> createState() => _CustomAnimatedToggleState();
}

class _CustomAnimatedToggleState extends State<CustomAnimatedToggle> {
  late CategoryType value;

  @override
  void initState() {
    value = widget.transactionType ?? CategoryType.expenses;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<CategoryType>.size(
      current: value,
      values: CategoryType.values,

      iconList: [
        CustomText(
          CategoryType.expenses.name,
          style: _customTextStyle(CategoryType.expenses),
        ),
        CustomText(
          CategoryType.income.name,
          style: _customTextStyle(CategoryType.income),
        ),
      ],

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
        backgroundColor: AppColors.black1,
        boxShadow: const [
          // BoxShadow(
          //   color: Colors.black26,
          //   spreadRadius: 1,
          //   blurRadius: 2,
          //   offset: Offset(0, 1.5),
          // ),
        ],
      ),
    );
  }

  TextStyle _customTextStyle(CategoryType type) {
    return TextStyle(
      fontSize: 14,
      color: value == type ? Colors.white : Colors.black54,
    );
  }
}
