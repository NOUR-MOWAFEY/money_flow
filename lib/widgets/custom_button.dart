import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.title = '',
    this.height = 60,
    this.width = double.infinity,
    this.color = AppColors.primaryColor,
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
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
      ),
    );
  }
}
