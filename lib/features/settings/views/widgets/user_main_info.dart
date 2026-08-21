import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({super.key, this.image, required this.name});
  final String? image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          // image
          CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: .5),
            radius: 28,
            child: CustomText(
              name[0],
              color: AppColors.primary.categoryIconColor,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          const SizedBox(width: 16),

          // username
          CustomText(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          // right icon
          const Spacer(),

          const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 18,
            color: AppColors.icon,
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
