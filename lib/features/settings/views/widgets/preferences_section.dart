import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/widgets/custom_divider.dart';
import 'package:money_flow/features/categories/views/manage_categories_view.dart';
import 'package:money_flow/features/settings/views/currency_view.dart';
import 'package:money_flow/features/settings/views/recurring_transactions_view.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section.dart';
import 'package:money_flow/features/settings/views/widgets/settings_section_item.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Preferences',

      child: Column(
        children: [
          SettingsSectionItem(
            icon: FontAwesomeIcons.moneyBills,
            title: 'Default Currency',
            subtitle: 'EGP',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => const CurrencyView()),
            ),
          ),

          const CustomDivider(),

          SettingsSectionItem(
            icon: FontAwesomeIcons.shapes,
            title: 'Manage Categories',
            subtitle: 'Organize your categories',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const ManageCategoriesView(),
              ),
            ),
          ),

          const CustomDivider(),

          SettingsSectionItem(
            icon: FontAwesomeIcons.rotate,
            title: 'Recurring Transactions',
            subtitle: 'View and edit repeating items',
            onTap: () => Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const RecurringTransactionsView(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
