import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.isFlexible = false,
    this.maxLines,
    this.color = Colors.white,
  });
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isFlexible;
  final int? maxLines;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return isFlexible
        ? Flexible(
            child: Text(
              text,
              maxLines: maxLines,
              style:
                  style?.copyWith(color: color) ??
                  TextStyle(color: AppColors.text),
              textAlign: textAlign,
            ),
          )
        : Text(
            text,
            style:
                style?.copyWith(color: color) ??
                TextStyle(color: AppColors.text),
            textAlign: textAlign,
          );
  }
}
