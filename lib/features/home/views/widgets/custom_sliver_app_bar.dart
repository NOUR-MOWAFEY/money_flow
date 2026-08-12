import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/home/views/widgets/home_view_app_bar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      toolbarHeight: 80,

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(vertical: 12),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HomeViewAppBar(),
        ),

        expandedTitleScale: 1.44,
        background: Container(height: 120, color: AppColors.primary),
      ),
    );
  }
}
