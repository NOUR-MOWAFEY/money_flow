import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomAnimatedToggle extends StatefulWidget {
  const CustomAnimatedToggle({
    super.key,
    required this.onChange,
    this.transactionType,
  });

  final void Function(TransactionType transactionType) onChange;
  final TransactionType? transactionType;

  @override
  State<CustomAnimatedToggle> createState() => _CustomAnimatedToggleState();
}

class _CustomAnimatedToggleState extends State<CustomAnimatedToggle> {
  late TransactionType value;

  @override
  void initState() {
    value = widget.transactionType ?? TransactionType.expenses;
    super.initState();
  }

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
        indicatorColor: AppColors.primaryColor,
        backgroundColor: AppColors.greyTrasparent,
        boxShadow: const [
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
