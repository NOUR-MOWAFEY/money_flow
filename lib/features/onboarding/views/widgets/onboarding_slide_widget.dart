import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/onboarding/data/models/onboarding_slide_model.dart';

class OnboardingSlideWidget extends StatelessWidget {
  const OnboardingSlideWidget({super.key, required this.slide});

  final OnboardingSlideModel slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge
          if (slide.badge != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: slide.accentColor.withAlpha(40),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: slide.accentColor.withAlpha(80)),
              ),
              child: CustomText(
                slide.badge!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: slide.accentColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],

          // Illustration card with glow
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  slide.accentColor.withAlpha(50),
                  AppColors.black1,
                ],
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
          ),
          const SizedBox(height: 44),

          // Title
          CustomText(
            slide.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          CustomText(
            slide.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white60,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
