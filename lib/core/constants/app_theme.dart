import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData mainTheme() {
    return ThemeData(
      fontFamily: 'Poppins',

      iconTheme: IconThemeData(color: AppColors.icon),

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),

      primaryColor: AppColors.primary,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
      datePickerTheme: DatePickerThemeData(
        dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return null;
        }),
        todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }

          return null;
        }),

        backgroundColor: AppColors.bg,
      ),
      scaffoldBackgroundColor: AppColors.bg,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bg,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColors.black,
        ),
      ),
    );
  }
}
