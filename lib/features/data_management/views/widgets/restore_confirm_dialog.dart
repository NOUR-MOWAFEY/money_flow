import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/data_management/data/models/restore_mode.dart';

class RestoreConfirmDialog extends StatelessWidget {
  final RestoreMode mode;
  final int itemCount;
  final VoidCallback onConfirm;

  const RestoreConfirmDialog({
    super.key,
    required this.mode,
    required this.itemCount,
    required this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required RestoreMode mode,
    required int itemCount,
    required VoidCallback onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return RestoreConfirmDialog(
          mode: mode,
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
    final isReplace = mode == RestoreMode.replace;

    return AlertDialog(
      backgroundColor: AppColors.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(
            isReplace
                ? Icons.warning_amber_rounded
                : Icons.help_outline_rounded,
            color: isReplace ? AppColors.error : AppColors.primary,
          ),
          const SizedBox(width: 10),
          const CustomText(
            'Confirm Restore',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            isReplace
                ? 'Warning: You selected "Replace Existing Data". Current data for the selected types will be erased and replaced with $itemCount records from this backup.'
                : 'Selected data ($itemCount items) will be merged into your current data without deleting anything.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text.withAlpha(180),
              height: 1.4,
            ),
          ),
          if (isReplace) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.error.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: CustomText(
                      'This action cannot be undone.',
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
            backgroundColor:
                isReplace ? AppColors.error : AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const CustomText(
            'Restore Now',
            color: Colors.white,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
