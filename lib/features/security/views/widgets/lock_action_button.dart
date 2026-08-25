import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

/// A circular action button used for biometric, clear, or backspace —
/// either an icon or a text label, never both.

class LockActionButton extends StatelessWidget {
  const LockActionButton({
    super.key,
    this.icon,
    this.label,
    this.iconSize,
    this.iconColor,
    required this.onTap,
  });

  final IconData? icon;
  final String? label;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),

        onTap: onTap,
        child: Container(
          width: 85,
          height: 85,
          alignment: Alignment.center,
          child: icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? AppColors.icon,
                  size: iconSize ?? 24,
                )
              : CustomText(
                  label ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}
