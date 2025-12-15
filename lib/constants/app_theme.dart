import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class AppTheme {
  static ThemeData mainTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
      ),
      datePickerTheme: DatePickerThemeData(
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }

          return null;
        }),
        todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }

          return null;
        }),

        backgroundColor: AppColors.secondaryColorWithHeightOpacity,
      ),
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColors.black,
        ),
      ),
    );
  }
}
