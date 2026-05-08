import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/widgets/home_view_app_bar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      toolbarHeight: 80,

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(vertical: 12),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HomeViewAppBar(),
        ),

        expandedTitleScale: 1.4,
        background: Container(height: 120, color: AppColors.primaryColor),
      ),
    );
  }
}
