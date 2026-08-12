import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/transactions/views/widgets/custom_floating_action_button.dart';
import 'package:money_flow/features/home/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      floatingActionButton: CustomFloatingActionButton(),
      body: HomeViewBody(),
    );
  }
}
