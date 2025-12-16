import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/widgets/custom_button.dart';
import 'package:money_flow/widgets/home_view_header.dart';

class ShowConfirmationDialog {
  static Future<dynamic> showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Are you sure?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Do you really want to delete all transactions?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
            ],
          ),
          actions: [
            CustomButton(title: 'No', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 6),
            CustomButton(
              title: 'Yes',
              onTap: () async {
                await HiveService().reset();
                BalanceController.updateBalance();
                if (context.mounted) Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
