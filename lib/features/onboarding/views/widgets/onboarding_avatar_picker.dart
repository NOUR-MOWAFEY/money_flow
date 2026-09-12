import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/profile/views/widgets/profile_image_picker_sheet.dart';

class OnboardingAvatarPicker extends StatelessWidget {
  const OnboardingAvatarPicker({
    super.key,
    required this.hasImage,
    required this.imagePath,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  final bool hasImage;
  final String? imagePath;
  final void Function(ImageSource) onPickImage;
  final VoidCallback onRemoveImage;

  void _showPicker(BuildContext context) {
    ProfileImagePickerSheet.show(
      context,
      hasImage: hasImage,
      onPickImage: onPickImage,
      onRemoveImage: onRemoveImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () => _showPicker(context),
              borderRadius: BorderRadius.circular(54),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primary.withAlpha(40),
                backgroundImage:
                    hasImage ? FileImage(File(imagePath!)) : null,
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
      ],
    );
  }
}
