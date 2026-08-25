import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

/// A reusable tile container used across security settings.
class SecuritySettingsTile extends StatelessWidget {
  const SecuritySettingsTile({
    super.key,
    required this.icon,
    this.iconSize = 18,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.isActive = false,
    this.isEnabled = true,
    this.onTap,
  });

  final FaIconData icon;
  final double iconSize;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final bool isActive;
  final bool isEnabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tile = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withAlpha(40)
              : Colors.white.withAlpha(10),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.black2,
            radius: 22,
            child: FaIcon(
              icon,
              color: AppColors.icon,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                CustomText(
                  subtitle,
                  color: AppColors.grey,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );

    final content = isEnabled
        ? tile
        : Opacity(
            opacity: 0.45,
            child: tile,
          );

    if (onTap != null && isEnabled) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: content,
        ),
      );
    }

    return content;
  }
}
