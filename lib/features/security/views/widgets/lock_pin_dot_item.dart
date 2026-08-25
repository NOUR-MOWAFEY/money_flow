import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

/// Single circular PIN indicator dot.
class LockPinDotItem extends StatelessWidget {
  const LockPinDotItem({
    super.key,
    required this.isFilled,
    required this.isError,
  });

  final bool isFilled;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: isFilled ? 18 : 14,
      height: isFilled ? 18 : 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isError
            ? AppColors.error
            : isFilled
            ? AppColors.primary
            : AppColors.black2,
        border: Border.all(
          color: isError
              ? AppColors.error
              : isFilled
              ? AppColors.primary
              : Colors.white.withAlpha(40),
          width: 1.5,
        ),
        boxShadow: isFilled && !isError
            ? [
                BoxShadow(
                  color: AppColors.primary.withAlpha(120),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
