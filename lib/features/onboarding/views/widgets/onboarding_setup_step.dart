import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_currencies.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';
import 'package:money_flow/features/onboarding/view_model/onboarding_cubit/onboarding_cubit.dart';
import 'package:money_flow/features/profile/views/widgets/profile_image_picker_sheet.dart';
import 'package:money_flow/features/settings/views/currency_view.dart';

class OnboardingSetupStep extends StatelessWidget {
  const OnboardingSetupStep({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnboardingCubit>();
    final state = cubit.state;

    final hasImage = state.imagePath != null &&
        state.imagePath!.isNotEmpty &&
        File(state.imagePath!).existsSync();

    final currency = AppCurrencies.currencies.firstWhere(
      (c) => c.code.toUpperCase() == state.currencyCode.toUpperCase(),
      orElse: () => AppCurrencies.currencies.first,
    );

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

          // Avatar Picker
          Stack(
            children: [
              InkWell(
                onTap: () => ProfileImagePickerSheet.show(
                  context,
                  hasImage: hasImage,
                  onPickImage: (source) => cubit.pickImage(source),
                  onRemoveImage: () => cubit.removeImage(),
                ),
                borderRadius: BorderRadius.circular(54),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.primary.withAlpha(40),
                  backgroundImage: hasImage
                      ? FileImage(File(state.imagePath!))
                      : null,
                  child: !hasImage
                      ? const Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 38,
                          color: AppColors.primary,
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.bg, width: 2.5),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const CustomText(
            'Photo (Optional)',
            style: TextStyle(fontSize: 11, color: Colors.white38),
          ),
          const SizedBox(height: 24),

          // Name field
          Align(
            alignment: Alignment.centerLeft,
            child: const CustomText(
              'Your Name',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormFiled(
            controller: nameController,
            hintText: 'e.g. Nour Mowafey',
            icon: Icons.person_outline_rounded,
            isNormalTextField: true,
            showPrefixIcon: true,
            centerText: false,
            showCursor: true,
            onChanged: (val) => cubit.updateName(val),
          ),
          const SizedBox(height: 20),

          // Currency Selector
          Align(
            alignment: Alignment.centerLeft,
            child: const CustomText(
              'Default Currency',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final selectedCode = await Navigator.of(context).push<String>(
                MaterialPageRoute(builder: (_) => const CurrencyView()),
              );
              if (selectedCode != null) {
                cubit.updateCurrency(selectedCode);
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.black1,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  CustomText(
                    currency.flag,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          currency.code,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomText(
                          currency.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    currency.code,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white38,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
