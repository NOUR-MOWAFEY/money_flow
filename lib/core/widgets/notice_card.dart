import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    super.key,
    this.icon = Icons.info_outline_rounded,
    required this.title,
    required this.description,
    this.accentColor = AppColors.primary,
    this.iconSize = 20,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(40),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withAlpha(40), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: iconSize),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 4),

                CustomText(
                  description,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: accentColor.withAlpha(180),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
