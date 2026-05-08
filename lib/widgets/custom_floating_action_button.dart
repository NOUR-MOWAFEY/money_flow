import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/views/add_transaction_view.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, this.size = 58});
  final double size;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: const CircleBorder(),
      closedColor: AppColors.primaryColor,
      transitionDuration: Duration(milliseconds: 350),

      closedBuilder: (context, action) => Container(
        height: size,
        width: size,

        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),

        child: const Center(
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      openBuilder: (context, action) => const AddTransactionView(),
    );
  }
}
