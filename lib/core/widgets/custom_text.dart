import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.isFlexible = false,
  });
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isFlexible;

  @override
  Widget build(BuildContext context) {
    return isFlexible
        ? Flexible(
            child: Text(
              text,

              style:
                  style?.copyWith(color: AppColors.text) ??
                  TextStyle(color: AppColors.text),
              textAlign: textAlign,
            ),
          )
        : Text(
            text,
            style:
                style?.copyWith(color: AppColors.text) ??
                TextStyle(color: AppColors.text),
            textAlign: textAlign,
          );
  }
}
