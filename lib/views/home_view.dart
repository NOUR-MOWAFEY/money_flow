import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/widgets/custom_floating_action_button.dart';
import 'package:money_flow/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: CustomFloatingActionButton(),
      body: HomeViewBody(),
    );
  }
}
