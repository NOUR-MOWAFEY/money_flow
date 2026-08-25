import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

/// A single circular digit button (0-9).
class LockKeyButton extends StatelessWidget {
  const LockKeyButton({super.key, required this.digit, required this.onTap});

  final String digit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(
        side: BorderSide(color: Colors.white.withAlpha(15), width: 1),
      ),
      color: AppColors.black1,
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor: AppColors.transparentPrimary,
        onTap: onTap,
        child: SizedBox(
          width: 85,
          height: 85,
          child: Center(
            child: CustomText(
              digit,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
