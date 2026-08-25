import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/features/security/views/security_settings_view.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section_item.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Security',
      child: SettingsSectionItem(
        icon: FontAwesomeIcons.fingerprint,
        title: 'Fingerprint / PIN',
        subtitle: 'App lock, biometric and PIN settings',
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => const SecuritySettingsView()),
        ),
      ),
    );
  }
}
