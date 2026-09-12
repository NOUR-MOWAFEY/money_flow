import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/onboarding/data/models/onboarding_slide_model.dart';

class OnboardingSlideIllustration extends StatelessWidget {
  const OnboardingSlideIllustration({super.key, required this.slide});

  final OnboardingSlideModel slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [slide.accentColor.withAlpha(50), AppColors.black1],
          radius: 0.85,
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: slide.accentColor.withAlpha(70),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: slide.accentColor.withAlpha(30),
            blurRadius: 36,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          slide.icon,
          size: 64,
          color: slide.accentColor,
        ),
      ),
    );
  }
}
