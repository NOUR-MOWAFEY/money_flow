import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_action_button.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_dots_indicator.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_split_back_button.dart';

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
    final hasBack = state.currentPage > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingDotsIndicator(
            count: state.totalPages,
            currentIndex: state.currentPage,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              OnboardingSplitBackButton(
                hasBack: hasBack,
                isSubmitting: state.isSubmitting,
                onBack: onBack,
              ),
              Expanded(
                child: OnboardingActionButton(
                  isLast: isLast,
                  isSubmitting: state.isSubmitting,
                  onPressed: isLast ? onSubmit : onNext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
