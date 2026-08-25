import 'package:flutter/material.dart';
import 'package:money_flow/features/security/view_model/security_settings_actions.dart';
import 'package:money_flow/features/security/view_model/security_settings_cubit/security_settings_state.dart';
import 'package:money_flow/features/security/views/widgets/change_pin_tile.dart';
import 'package:money_flow/features/security/views/widgets/security_section_header.dart';

class SecurityPinSection extends StatelessWidget {
  const SecurityPinSection({
    super.key,
    required this.state,
  });

  final SecuritySettingsState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SecuritySectionHeader(title: 'PIN Management'),
        const SizedBox(height: 12),
        ChangePinTile(
          isAppLockEnabled: state.isAppLockEnabled,
          hasPin: state.hasPin,
          onTap: () => SecuritySettingsActions.handleChangePin(context),
        ),
      ],
    );
  }
}
