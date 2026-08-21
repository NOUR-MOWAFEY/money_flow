import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class SettingsSectionItem extends StatelessWidget {
  const SettingsSectionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
  final FaIconData icon;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: onTap,

      child: Row(
        // icon
        children: [
          CircleAvatar(
            backgroundColor: AppColors.black2,
            radius: 22,
            child: FaIcon(icon, color: AppColors.icon, size: 20),
          ),

          const SizedBox(width: 12),

          // title
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CustomText(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 2),

                // subtitle
                CustomText(
                  subtitle,
                  color: AppColors.grey,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,

                    overflow: .ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),

          const SizedBox(width: 4),

          const FaIcon(FontAwesomeIcons.chevronRight, size: 16),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
