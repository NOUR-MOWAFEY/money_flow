import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class OnboardingSlideModel {
  const OnboardingSlideModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    this.badge,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final String? badge;

  static const List<OnboardingSlideModel> defaultSlides = [
    OnboardingSlideModel(
      title: 'Track Every Penny',
      description:
          'Effortlessly log income and daily expenses with categories, notes, and instant real-time balance calculations.',
      icon: Icons.account_balance_wallet_rounded,
      accentColor: AppColors.primary,
      badge: 'Cash Flow',
    ),
    OnboardingSlideModel(
      title: 'Set Smart Budgets',
      description:
          'Establish monthly or weekly spending limits for categories to stay disciplined and save more money.',
      icon: Icons.track_changes_rounded,
      accentColor: Color(0xFF4CAF50),
      badge: 'Budgeting',
    ),
    OnboardingSlideModel(
      title: 'Visual Insights & Charts',
      description:
          'Gain complete visibility over your financial habits with rich interactive trend charts and spending breakdowns.',
      icon: Icons.pie_chart_rounded,
      accentColor: Color(0xFFFF9800),
      badge: 'Analytics',
    ),
  ];
}
