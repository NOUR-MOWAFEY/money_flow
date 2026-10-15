import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ResetConfirmDialog extends StatelessWidget {
  final int itemCount;
  final VoidCallback onConfirm;

  const ResetConfirmDialog({
    super.key,
    required this.itemCount,
    required this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required int itemCount,
    required VoidCallback onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return DialogOpenAnimation(
          child: ResetConfirmDialog(
            itemCount: itemCount,
            onConfirm: () {
              Navigator.pop(dialogContext, true);
              onConfirm();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Column(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 70,
            color: AppColors.error,
          ),
          SizedBox(height: 8),
          CustomText(
            'Permanently Delete?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Are you sure you want to delete $itemCount selected records? This will permanently erase your data from this device.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text.withAlpha(180),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.error.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppColors.error,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CustomText(
                    'This action cannot be undone. Consider exporting a backup first.',
                    color: AppColors.error,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          onTap: () => Navigator.pop(context, false),
        ),
        CustomButton(
          title: 'Delete',
          width: 120,
          height: 42,
          color: AppColors.error,
          textSize: 14,
          onTap: onConfirm,
        ),
      ],
    );
  }
}
