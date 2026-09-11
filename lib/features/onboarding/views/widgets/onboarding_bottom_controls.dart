import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_dots_indicator.dart';

class OnboardingBottomControls extends StatelessWidget {
  const OnboardingBottomControls({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onSubmit,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OnboardingCubit>().state;
    final isLast = state.currentPage == state.totalPages - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingDotsIndicator(
            count: state.totalPages,
            currentIndex: state.currentPage,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              if (state.currentPage > 0)
                IconButton(
                  onPressed: state.isSubmitting ? null : onBack,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white70,
                    size: 20,
                  ),
                  tooltip: 'Back',
                )
              else
                const SizedBox(width: 48),
              const SizedBox(width: 12),
              Expanded(
                child: isLast
                    ? CustomButton(
                        title: state.isSubmitting ? 'Setting Up...' : 'Get Started',
                        onTap: state.isSubmitting ? null : onSubmit,
                      )
                    : ElevatedButton(
                        onPressed: onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
              ),
              if (state.currentPage == 0) const SizedBox(width: 48),
            ],
          ),
        ],
      ),
    );
  }
}
