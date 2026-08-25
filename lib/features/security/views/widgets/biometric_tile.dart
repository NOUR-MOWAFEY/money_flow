import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/security/views/widgets/security_settings_tile.dart';

class BiometricTile extends StatelessWidget {
  const BiometricTile({
    super.key,
    required this.isAppLockEnabled,
    required this.isBiometricSupported,
    required this.isBiometricEnabled,
    required this.onToggle,
  });

  final bool isAppLockEnabled;
  final bool isBiometricSupported;
  final bool isBiometricEnabled;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = isAppLockEnabled && isBiometricSupported;

    return SecuritySettingsTile(
      icon: FontAwesomeIcons.fingerprint,
      iconSize: 20,
      title: 'Fingerprint / Biometrics',
      subtitle: !isBiometricSupported
          ? 'Biometrics not supported on this device'
          : !isAppLockEnabled
          ? 'Enable App Lock first'
          : 'Unlock using Fingerprint or Face ID',
      isActive: isBiometricEnabled && isAppLockEnabled,
      isEnabled: isEnabled,
      trailing: FlutterSwitch(
        height: 30,
        width: 58,
        toggleSize: 23,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.black2,
        disabled: !isEnabled,
        value: isBiometricEnabled && isAppLockEnabled,
        onToggle: onToggle,
      ),
    );
  }
}
