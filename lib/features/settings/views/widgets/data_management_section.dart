import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section_item.dart';

class DataManagementSection extends StatelessWidget {
  const DataManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Data Management',

      child: const Column(
        children: [
          SettingsSectionItem(
            icon: FontAwesomeIcons.arrowRightArrowLeft,
            title: 'Export & Import Data',
            subtitle: 'CSV, JSON formats',
          ),

          Divider(height: 28, indent: 20, endIndent: 20),

          SettingsSectionItem(
            icon: FontAwesomeIcons.trash,
            title: 'Reset Data',
            subtitle: 'Permanently delete all data',
          ),
        ],
      ),
    );
  }
}
