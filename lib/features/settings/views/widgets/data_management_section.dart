import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/widgets/custom_divider.dart';
import 'package:money_flow/features/data_management/views/backup_view.dart';
import 'package:money_flow/features/data_management/views/reset_view.dart';
import 'package:money_flow/features/data_management/views/restore_view.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section_item.dart';

class DataManagementSection extends StatelessWidget {
  const DataManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Data Management',
      child: Column(
        children: [
          SettingsSectionItem(
            icon: FontAwesomeIcons.solidCloud,
            title: 'Backup Data',
            subtitle: 'Export JSON backup of your data',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const BackupView(),
              ),
            ),
          ),
          const CustomDivider(),
          SettingsSectionItem(
            icon: FontAwesomeIcons.rotateRight,
            title: 'Restore Data',
            subtitle: 'Restore from a JSON backup file',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const RestoreView(),
              ),
            ),
          ),
          const CustomDivider(),
          SettingsSectionItem(
            icon: FontAwesomeIcons.trash,
            title: 'Reset Data',
            subtitle: 'Permanently delete all data',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const ResetView(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
