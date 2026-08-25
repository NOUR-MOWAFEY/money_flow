import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/security/views/widgets/security_settings_tile.dart';

class AppLockTile extends StatelessWidget {
  const AppLockTile({
    super.key,
    required this.isAppLockEnabled,
    required this.onToggle,
  });

  final bool isAppLockEnabled;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return SecuritySettingsTile(
      icon: FontAwesomeIcons.shieldHalved,
      title: 'App Lock',
      subtitle: isAppLockEnabled
          ? 'App is protected with 6-digit PIN'
          : 'Enable 6-digit PIN to secure the app',
      isActive: isAppLockEnabled,
      trailing: FlutterSwitch(
        height: 30,
        width: 58,
        toggleSize: 23,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.black2,
        value: isAppLockEnabled,
        onToggle: onToggle,
      ),
    );
  }
}
