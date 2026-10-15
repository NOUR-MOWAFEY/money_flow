import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    super.key,
    this.title = 'Are you sure ?',
    required this.description,
    this.confirmTitle = 'Delete',
    this.cancelTitle = 'Cancel',
    this.confirmColor = AppColors.error,
    this.cancelColor = AppColors.black1,
    this.icon = CupertinoIcons.exclamationmark_circle,
    this.iconColor = AppColors.error,
    this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String description;
  final String confirmTitle;
  final String cancelTitle;
  final Color confirmColor;
  final Color cancelColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        children: [
          Icon(
            icon,
            size: 70,
            color: iconColor,
          ),
          const SizedBox(height: 8),
          CustomText(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: CustomText(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
          height: 1.4,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButton(
          title: cancelTitle,
          width: 100,
          height: 42,
          color: cancelColor,
          textSize: 14,
          onTap: onCancel ?? () => Navigator.of(context).pop(),
        ),
        CustomButton(
          title: confirmTitle,
          width: 120,
          height: 42,
          color: confirmColor,
          textSize: 14,
          onTap: onConfirm,
        ),
      ],
    );
  }
}

class ShowConfirmationDialog {
  static Future<bool?> show(
    BuildContext context, {
    String title = 'Are you sure ?',
    required String description,
    String confirmTitle = 'Delete',
    String cancelTitle = 'Cancel',
    Color confirmColor = AppColors.error,
    Color cancelColor = AppColors.black1,
    IconData icon = CupertinoIcons.exclamationmark_circle,
    Color iconColor = AppColors.error,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogCtx) => DialogOpenAnimation(
        child: CustomConfirmationDialog(
          title: title,
          description: description,
          confirmTitle: confirmTitle,
          cancelTitle: cancelTitle,
          confirmColor: confirmColor,
          cancelColor: cancelColor,
          icon: icon,
          iconColor: iconColor,
          onConfirm: () {
            Navigator.of(dialogCtx).pop(true);
            onConfirm?.call();
          },
          onCancel: () {
            Navigator.of(dialogCtx).pop(false);
            onCancel?.call();
          },
        ),
      ),
    );
  }

  static Future<dynamic> showConfirmationDialog(
    BuildContext context, {
    String? title,
    String? subtitle,
    void Function()? onTapYes,
    void Function()? onTapNo,
  }) {
    return show(
      context,
      title: title ?? 'Are you sure ?',
      description: subtitle ?? 'Do you really want to proceed?',
      confirmTitle: 'Yes',
      cancelTitle: 'No',
      onConfirm: onTapYes,
      onCancel: onTapNo,
    );
  }
}
