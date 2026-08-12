import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ShowConfirmationDialog {
  static Future<dynamic> showConfirmationDialog(
    BuildContext context, {
    String? title,
    String? subtitle,
    void Function()? onTapYes,
    void Function()? onTapNo,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              CustomText(
                title ?? 'Are you sure?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              CustomText(
                subtitle ?? 'Do you really want to delete all transactions?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
            ],
          ),
          actions: [
            CustomButton(
              title: 'No',
              onTap: onTapNo ?? () => Navigator.pop(context),
            ),
            const SizedBox(height: 6),
            CustomButton(
              title: 'Yes',
              onTap:
                  onTapYes ??
                  () async {
                    await HiveService().reset();

                    if (context.mounted) Navigator.pop(context);
                  },
            ),
          ],
        );
      },
    );
  }
}
