import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        subtitle: 'Require biometric authentication',
      ),
    );
  }
}
