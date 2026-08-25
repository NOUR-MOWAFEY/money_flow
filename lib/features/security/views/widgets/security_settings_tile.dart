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
    final tile = _SecuritySettingsTileContainer(
      isActive: isActive,
      child: Row(
        children: [
          _SecuritySettingsTileIcon(icon: icon, iconSize: iconSize),

          const SizedBox(width: 14),

          _SecuritySettingsTileTitles(title: title, subtitle: subtitle),

          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );

    final content = isEnabled ? tile : Opacity(opacity: 0.45, child: tile);

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

class _SecuritySettingsTileContainer extends StatelessWidget {
  const _SecuritySettingsTileContainer({
    required this.isActive,

    required this.child,
  });

  final bool isActive;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withAlpha(80)
              : Colors.white.withAlpha(10),
          width: 2,
        ),
      ),
      child: child,
    );
  }
}

class _SecuritySettingsTileTitles extends StatelessWidget {
  const _SecuritySettingsTileTitles({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          const SizedBox(height: 4),

          CustomText(
            subtitle,
            color: AppColors.grey,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class _SecuritySettingsTileIcon extends StatelessWidget {
  const _SecuritySettingsTileIcon({required this.icon, required this.iconSize});

  final FaIconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.black2,
      radius: 22,
      child: FaIcon(icon, color: AppColors.icon, size: iconSize),
    );
  }
}
