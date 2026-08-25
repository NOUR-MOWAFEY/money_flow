import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

/// Header shown at the top of lock and PIN screens: icon, title and
/// subtitle. Reusable across LockView and PinScreen.
class LockHeader extends StatelessWidget {
  const LockHeader({
    super.key,
    this.icon = FontAwesomeIcons.lock,
    this.title = 'Welcome Back',
    this.subtitle = 'Enter your 6-digit PIN to access Money Flow',
  });

  final FaIconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withAlpha(30),
            border: Border.all(
              color: AppColors.primary.withAlpha(80),
              width: 1.5,
            ),
          ),
          child: Center(
            child: FaIcon(
              icon,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomText(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        CustomText(
          subtitle,
          textAlign: TextAlign.center,
          color: AppColors.grey,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
