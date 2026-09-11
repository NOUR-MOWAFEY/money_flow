import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          child: OnboardingViewBody(),
        ),
      ),
    );
  }
}
