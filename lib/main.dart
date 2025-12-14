import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/views/home_view.dart';

void main() {
  runApp(const MoneyFlowApp());
}

class MoneyFlowApp extends StatelessWidget {
  const MoneyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
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
      ),
      home: const HomeView(),
    );
  }
}
