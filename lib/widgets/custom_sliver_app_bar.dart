import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/widgets/home_view_app_bar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      toolbarHeight: 75,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(vertical: 8),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HomeViewAppBar(),
        ),

        expandedTitleScale: 1.27,
        background: Container(height: 120, color: AppColors.primaryColor),
      ),
    );
  }
}
