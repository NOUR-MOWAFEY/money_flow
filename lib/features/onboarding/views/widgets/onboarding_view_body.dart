import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/onboarding/data/models/onboarding_slide_model.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_state.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_bottom_controls.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_header.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_setup_step.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_slide_widget.dart';
import 'package:money_flow/features/security/views/app_lock_gate.dart';
import 'package:money_flow/main_nav_view.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final PageController _pageController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _onStateChanged(BuildContext context, OnboardingState state) {
    if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
      ShowToastification.failure(context, state.errorMessage!);
    }
    if (state.isCompleted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AppLockGate(child: MainNavView()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.isCompleted != current.isCompleted,
      listener: _onStateChanged,
      builder: (context, state) {
        final isLastPage = state.currentPage == state.totalPages - 1;

        return Column(
          children: [
            OnboardingHeader(
              isLastPage: isLastPage,
              onSkip: () {
                cubit.skipToSetup();
                _goToPage(state.totalPages - 1);
              },
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => cubit.setPage(index),
                children: [
                  ...OnboardingSlideModel.defaultSlides.map(
                    (slide) => OnboardingSlideWidget(slide: slide),
                  ),
                  OnboardingSetupStep(nameController: _nameController),
                ],
              ),
            ),
            OnboardingBottomControls(
              onNext: () {
                final next = state.currentPage + 1;
                cubit.nextPage();
                _goToPage(next);
              },
              onBack: () {
                FocusManager.instance.primaryFocus?.unfocus();
                final prev = state.currentPage - 1;
                if (prev >= 0) {
                  cubit.setPage(prev);
                  _goToPage(prev);
                }
              },
              onSubmit: () => cubit.completeOnboarding(),
            ),
          ],
        );
      },
    );
  }
}
