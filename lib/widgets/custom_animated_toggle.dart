import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomAnimatedToggle extends StatefulWidget {
  const CustomAnimatedToggle({super.key, required this.onChange});

  final void Function(TransactionType transactionType) onChange;

  @override
  State<CustomAnimatedToggle> createState() => _CustomAnimatedToggleState();
}

class _CustomAnimatedToggleState extends State<CustomAnimatedToggle> {
  TransactionType value = TransactionType.expenses;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<TransactionType>.size(
      current: value,
      values: TransactionType.values,

      iconList: [
        Text(
          TransactionType.expenses.name,
          style: _customTextStyle(TransactionType.expenses),
        ),
        Text(
          TransactionType.income.name,
          style: _customTextStyle(TransactionType.income),
        ),
      ],

      // iconOpacity: 0.2,
      indicatorSize: const Size.fromWidth(160),
      borderWidth: 4.0,
      iconAnimationType: AnimationType.onSelected,
      selectedIconScale: 1.2,

      onChanged: (value) {
        widget.onChange(value);
        setState(() => this.value = value);
      },

      style: ToggleStyle(
        borderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        indicatorColor: AppColors.primaryColor,
        backgroundColor: AppColors.greyTrasparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
    );
  }

  TextStyle _customTextStyle(TransactionType type) {
    return TextStyle(
      fontSize: 14,
      color: value == type ? Colors.white : Colors.black54,
    );
  }
}

enum TransactionType { expenses, income }
