import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
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
        return ResetConfirmDialog(
          itemCount: itemCount,
          onConfirm: () {
            Navigator.pop(dialogContext, true);
            onConfirm();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.error,
          ),
          SizedBox(width: 10),
          CustomText(
            'Permanently Delete?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Are you sure you want to delete $itemCount selected records? This will permanently erase your data from this device.',
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const CustomText(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        FilledButton(
          onPressed: onConfirm,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.error,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const CustomText(
            'Delete Permanently',
            color: Colors.white,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
