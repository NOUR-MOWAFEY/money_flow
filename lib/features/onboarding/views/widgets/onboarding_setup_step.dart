import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_avatar_picker.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_currency_selector.dart';
import 'package:money_flow/features/onboarding/views/widgets/onboarding_name_field.dart';

class OnboardingSetupStep extends StatelessWidget {
  const OnboardingSetupStep({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnboardingCubit>();
    final state = cubit.state;

    final hasImage = state.imagePath != null &&
        state.imagePath!.isNotEmpty &&
        File(state.imagePath!).existsSync();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          const CustomText(
            'Personalize Your App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const CustomText(
            'Configure your profile and primary currency',
            style: TextStyle(fontSize: 13, color: Colors.white54),
          ),
          const SizedBox(height: 28),
          OnboardingAvatarPicker(
            hasImage: hasImage,
            imagePath: state.imagePath,
            onPickImage: (source) => cubit.pickImage(source),
            onRemoveImage: () => cubit.removeImage(),
          ),
          const SizedBox(height: 24),
          OnboardingNameField(
            controller: nameController,
            onChanged: (val) => cubit.updateName(val),
          ),
          const SizedBox(height: 20),
          OnboardingCurrencySelector(
            currencyCode: state.currencyCode,
            onCurrencySelected: (code) => cubit.updateCurrency(code),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
