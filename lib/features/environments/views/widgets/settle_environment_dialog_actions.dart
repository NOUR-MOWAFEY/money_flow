import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class SettleEnvironmentDialogActions extends StatelessWidget {
  const SettleEnvironmentDialogActions({
    super.key,
    required this.onCancel,
    required this.onSettle,
  });

  final VoidCallback onCancel;
  final VoidCallback onSettle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          title: 'Cancel',
          width: 100,
          height: 42,
          color: AppColors.black1,
          textSize: 14,
          onTap: onCancel,
        ),
        const SizedBox(width: 12),
        CustomButton(
          title: 'Settle',
          width: 120,
          height: 42,
          color: Colors.green,
          textSize: 14,
          onTap: onSettle,
        ),
      ],
    );
  }
}
