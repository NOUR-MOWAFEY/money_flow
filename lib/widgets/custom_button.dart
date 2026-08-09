import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.title = '',
    this.height = 56,
    this.width = double.infinity,
    this.color = AppColors.primary,
    this.child,
  });
  final void Function()? onTap;
  final String title;
  final double height;
  final double width;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
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
                  color: AppColors.bg,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
      ),
    );
  }
}
