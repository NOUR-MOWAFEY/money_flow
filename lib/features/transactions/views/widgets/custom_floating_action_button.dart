import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.size = 58,
    required this.view,
  });
  final double size;
  final Widget view;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: const CircleBorder(),
      closedColor: AppColors.primary,

      useRootNavigator: true,

      closedBuilder: (context, action) => Container(
        height: size,
        width: size,

        decoration: const BoxDecoration(color: AppColors.primary),

        child: Center(
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: (28 / 58) * size,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      openBuilder: (context, action) => view,
    );
  }
}
