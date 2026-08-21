import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/budget/views/budget_view.dart';
import 'package:money_flow/features/home/views/home_view.dart';
import 'package:money_flow/features/reports/views/reports_view.dart';
import 'package:money_flow/features/settings/views/settings_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainNavView extends StatelessWidget {
  const MainNavView({super.key});

  // ---------- Colors ----------
  static const Color _activeColor = Colors.blue;
  static const Color _inactiveColor = Colors.white24;
  static final Color _barColor = AppColors.bg;
  // .withValues(
  //   alpha: .7,
  // ); // translucent dark bar

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _buildTabs(),
      navBarOverlap: const NavBarOverlap.full(),
      backgroundColor: Colors.transparent,
      keepNavigatorHistory: false,
      resizeToAvoidBottomInset: false,
      navBarBuilder: (navBarConfig) => _buildNavBar(navBarConfig),
    );
  }

  // ---------- Tabs ----------
  List<PersistentTabConfig> _buildTabs() {
    return [
      _homeTab(),
      _chartsTab(),
      _budgetTab(),
      _transactionsHistoryTab(),
      _settingsTab(),
    ];
  }

  PersistentTabConfig _homeTab() {
    return PersistentTabConfig(
      screen: const HomeView(),
      item: _customIconConfig(FontAwesomeIcons.solidHouse, "Home"),
    );
  }

  PersistentTabConfig _chartsTab() {
    return PersistentTabConfig(
      screen: const ReportsView(),
      item: _customIconConfig(FontAwesomeIcons.chartSimple, "Charts"),
    );
  }

  PersistentTabConfig _budgetTab() {
    return PersistentTabConfig(
      screen: const BudgetView(),
      item: _customIconConfig(FontAwesomeIcons.wallet, "Budget"),
    );
  }

  PersistentTabConfig _transactionsHistoryTab() {
    return PersistentTabConfig(
      screen: const HomeView(),
      item: _customIconConfig(FontAwesomeIcons.clockRotateLeft, "History"),
    );
  }

  PersistentTabConfig _settingsTab() {
    return PersistentTabConfig(
      screen: const SettingsView(),
      item: _customIconConfig(FontAwesomeIcons.gear, "Settings"),
    );
  }

  // ---------- Shared Item Config ----------
  ItemConfig _customIconConfig(FaIconData? activeIcon, String title) {
    return ItemConfig(
      icon: FaIcon(activeIcon),
      iconSize: 22,
      inactiveForegroundColor: _inactiveColor,
      activeForegroundColor: _activeColor,
      activeColorSecondary: _activeColor,
    );
  }

  // ---------- Nav Bar ----------
  Widget _buildNavBar(NavBarConfig navBarConfig) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(32),
      child: Style9BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: _navBarDecoration(),
      ),
    );
  }

  NavBarDecoration _navBarDecoration() {
    return NavBarDecoration(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
      color: _barColor,
    );
  }
}
