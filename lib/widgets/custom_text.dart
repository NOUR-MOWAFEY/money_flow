import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text, {super.key, this.style, this.textAlign});
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style?.copyWith(color: AppColors.text) ??
          TextStyle(color: AppColors.text),
      textAlign: textAlign,
    );
  }
}
