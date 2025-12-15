import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_theme.dart';
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
      theme: AppTheme.mainTheme(),
      home: const HomeView(),
    );
  }
}
