import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/features/home/views/widgets/home_view_app_bar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      pinned: true,
      automaticallyImplyLeading: false,
      // backgroundColor: AppColors.primary,
      toolbarHeight: 70,

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(top: 6, bottom: 12),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.viewPadding),
          child: HomeViewAppBar(),
        ),

        expandedTitleScale: 1.44,

        background: Container(
          height: 30,
          // color: AppColors.error,
          alignment: .topStart,
        ),
      ),
    );
  }
}
