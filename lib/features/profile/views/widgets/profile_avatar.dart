import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.imagePath,
    required this.name,
    required this.onTap,
  });

  final String? imagePath;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasValidImage = imagePath != null &&
        imagePath!.isNotEmpty &&
        File(imagePath!).existsSync();

    return Center(
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(60),
            child: CircleAvatar(
              radius: 54,
              backgroundColor: AppColors.primary.withAlpha(40),
              backgroundImage: hasValidImage
                  ? FileImage(File(imagePath!))
                  : null,
              child: !hasValidImage
                  ? CustomText(
                      name.trim().isNotEmpty
                          ? name.trim()[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bg, width: 3),
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
