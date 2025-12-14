import 'package:flutter/material.dart';
import 'package:money_flow/widgets/custom_app_bar.dart';

class AnalyticsBody extends StatelessWidget {
  const AnalyticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [SizedBox(height: 16), const CustomAppBar()]),
    );
  }
}
