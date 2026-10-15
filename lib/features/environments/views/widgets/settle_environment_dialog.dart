import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/settle_environment_dialog_header.dart';
import 'package:money_flow/features/environments/views/widgets/settle_environment_remainder_checkbox.dart';

class SettleEnvironmentDialog extends StatefulWidget {
  const SettleEnvironmentDialog({
    super.key,
    required this.environment,
    required this.onConfirm,
  });

  final EnvironmentModel environment;
  final void Function(bool returnRemainder) onConfirm;

  @override
  State<SettleEnvironmentDialog> createState() =>
      _SettleEnvironmentDialogState();
}

class _SettleEnvironmentDialogState extends State<SettleEnvironmentDialog> {
  bool _returnRemainder = true;

  @override
  Widget build(BuildContext context) {
    String currency = 'EGP';
    try {
      currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';
    } catch (_) {}
    final remaining = widget.environment.currentBalance;
    final hasRemainder = remaining > 0;

    return AlertDialog(
      backgroundColor: AppColors.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const SettleEnvironmentDialogHeader(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Are you sure you want to complete "${widget.environment.name}"? This marks the environment as finished.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          if (hasRemainder) ...[
            const SizedBox(height: 16),
            SettleEnvironmentRemainderCheckbox(
              value: _returnRemainder,
              currency: currency,
              remaining: remaining,
              onChanged: (val) => setState(() => _returnRemainder = val),
            ),
          ],
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButton(
          title: 'Cancel',
          width: 100,
          height: 42,
          color: AppColors.black1,
          textSize: 14,
          onTap: () => Navigator.of(context).pop(),
        ),
        CustomButton(
          title: 'Settle',
          width: 120,
          height: 42,
          color: Colors.green,
          textSize: 14,
          onTap: () {
            Navigator.of(context).pop();
            widget.onConfirm(_returnRemainder);
          },
        ),
      ],
    );
  }
}
