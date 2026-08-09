import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  late String imagePath;

  @override
  void initState() {
    imagePath = HiveService.userImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.greyTrasparent,
      backgroundImage: imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
      child: imagePath.isEmpty
          ? const Icon(Icons.person, color: AppColors.icon)
          : null,
    );
  }
}
