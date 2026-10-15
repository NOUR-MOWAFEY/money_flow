import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.title = '',
    this.height = 52,
    this.width = double.infinity,
    this.color = AppColors.primary,
    this.child,
    this.textSize,
    this.textColor,
  });
  final void Function()? onTap;
  final String title;
  final double height;
  final double width;
  final Color color;
  final Widget? child;
  final double? textSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ??
        ((color == AppColors.black1 ||
                color == AppColors.bg ||
                color == AppColors.black)
            ? AppColors.text
            : AppColors.bg);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        height: height,
        width: width,
        child:
            child ??
            Center(
              child: CustomText(
                title,
                style: TextStyle(
                  color: effectiveTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: textSize ?? 16,
                ),
              ),
            ),
      ),
    );
  }
}
