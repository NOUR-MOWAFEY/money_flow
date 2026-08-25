import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/security/views/widgets/security_settings_tile.dart';

class ChangePinTile extends StatelessWidget {
  const ChangePinTile({
    super.key,
    required this.isAppLockEnabled,
    required this.hasPin,
    required this.onTap,
  });

  final bool isAppLockEnabled;
  final bool hasPin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = isAppLockEnabled && hasPin;

    return SecuritySettingsTile(
      icon: FontAwesomeIcons.key,
      title: 'Change PIN',
      subtitle: isEnabled
          ? 'Update your current 6-digit PIN'
          : 'Enable App Lock to set a PIN',
      isEnabled: isEnabled,
      onTap: onTap,
      trailing: const Padding(
        padding: EdgeInsets.only(right: 4),
        child: FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 16,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
