import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class NoActiveEnvironmentsCard extends StatelessWidget {
  const NoActiveEnvironmentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.layers_clear_outlined,
            size: 40,
            color: Colors.white30,
          ),
          SizedBox(height: 12),
          CustomText(
            'No Active Environments',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          SizedBox(height: 6),
          CustomText(
            'All environments are closed. Tap "+" to create a new one, or tap the history icon in the app bar to view closed environments.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
