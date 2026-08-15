import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

Color getContrastColor(Color backgroundColor) {
  return ThemeData.estimateBrightnessForColor(backgroundColor) ==
          Brightness.light
      ? AppColors.iconDark
      : AppColors.icon;
}
