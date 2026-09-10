import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ExportOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onSaveToDevice;
  final VoidCallback onShare;

  const ExportOptionsBottomSheet({
    super.key,
    required this.onSaveToDevice,
    required this.onShare,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onSaveToDevice,
    required VoidCallback onShare,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return ExportOptionsBottomSheet(
          onSaveToDevice: () {
            Navigator.pop(sheetContext);
            onSaveToDevice();
          },
          onShare: () {
            Navigator.pop(sheetContext);
            onShare();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(
              'Export Backup',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            CustomText(
              'Choose how you want to export your backup JSON file',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.text.withAlpha(150),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(40),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.save_alt_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              title: const CustomText(
                'Save to Device',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              subtitle: CustomText(
                'Select a folder on your device to save the file',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.text.withAlpha(140),
                ),
              ),
              onTap: onSaveToDevice,
            ),
            const Divider(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(40),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.share_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              title: const CustomText(
                'Share Backup',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              subtitle: CustomText(
                'Send via WhatsApp, Google Drive, Email, etc.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.text.withAlpha(140),
                ),
              ),
              onTap: onShare,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
