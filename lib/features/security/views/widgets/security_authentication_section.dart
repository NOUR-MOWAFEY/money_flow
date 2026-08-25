import 'package:flutter/material.dart';
import 'package:money_flow/features/security/view_model/security_settings_actions.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_state.dart';
import 'package:money_flow/features/security/views/widgets/app_lock_tile.dart';
import 'package:money_flow/features/security/views/widgets/biometric_tile.dart';
import 'package:money_flow/features/security/views/widgets/security_section_header.dart';

class SecurityAuthenticationSection extends StatelessWidget {
  const SecurityAuthenticationSection({super.key, required this.state});

  final SecuritySettingsState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SecuritySectionHeader(title: 'Authentication'),

        const SizedBox(height: 12),

        AppLockTile(
          isAppLockEnabled: state.isAppLockEnabled,
          onToggle: (val) =>
              SecuritySettingsActions.handleAppLockToggle(context, state, val),
        ),

        const SizedBox(height: 16),

        BiometricTile(
          isAppLockEnabled: state.isAppLockEnabled,
          isBiometricSupported: state.isBiometricSupported,
          isBiometricEnabled: state.isBiometricEnabled,
          onToggle: (val) => SecuritySettingsActions.handleBiometricToggle(
            context,
            state,
            val,
          ),
        ),
      ],
    );
  }
}
