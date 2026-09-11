import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, this.radius = 20});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, _) {
        final user = HiveService.getUserModel();
        final imagePath = user?.imagePath;
        final hasValidImage = imagePath != null &&
            imagePath.isNotEmpty &&
            File(imagePath).existsSync();
        final name = user?.name.trim() ?? '';

        return CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.primary.withAlpha(50),
          backgroundImage: hasValidImage ? FileImage(File(imagePath)) : null,
          child: !hasValidImage
              ? (name.isNotEmpty
                  ? CustomText(
                      name[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: radius * 0.9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    )
                  : const Icon(Icons.person, color: AppColors.icon))
              : null,
        );
      },
    );
  }
}
