import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/profile/views/profile_view.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({super.key, this.image, this.name = 'User'});
  final String? image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, snapshot) {
        final user = HiveService.getUserModel();
        final displayName = (user != null && user.name.trim().isNotEmpty)
            ? user.name.trim()
            : name;
        final imagePath = user?.imagePath ?? image;
        final hasValidImage = imagePath != null &&
            imagePath.isNotEmpty &&
            File(imagePath).existsSync();

        return InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const ProfileView()),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.black1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withAlpha(80),
                  radius: 28,
                  backgroundImage: hasValidImage
                      ? FileImage(File(imagePath))
                      : null,
                  child: !hasValidImage
                      ? CustomText(
                          displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                          color: AppColors.primary.categoryIconColor,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const CustomText(
                        'Tap to edit profile',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 16,
                  color: AppColors.icon,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
