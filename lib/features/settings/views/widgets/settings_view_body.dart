import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/view_header.dart';
import 'package:money_flow/features/settings/views/widgets/data_management_section.dart';
import 'package:money_flow/features/settings/views/widgets/preferences_section.dart';
import 'package:money_flow/features/settings/views/widgets/security_section.dart';
import 'package:money_flow/features/settings/views/widgets/user_main_info.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),

      child: ListView(
        children: const [
          ViewHeader(title: 'Settings'),

          UserMainInfo(name: 'Nour Mowafey'),

          SizedBox(height: 28),

          PreferencesSection(),

          SizedBox(height: 28),

          SecuritySection(),

          SizedBox(height: 28),

          DataManagementSection(),

          SizedBox(height: AppDimensions.viewBottomSpace),
        ],
      ),
    );
  }
}
