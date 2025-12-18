import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/views/profile_view.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    String imagePath = HiveService.userImage;
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView()),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                backgroundImage: imagePath.isNotEmpty
                    ? FileImage(File(imagePath))
                    : null,
                child: imagePath.isEmpty
                    ? const Icon(Icons.person, color: AppColors.white)
                    : null,
              ),
              SizedBox(width: 12),
              Text(
                HiveService.userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(83, 158, 158, 158),
            borderRadius: BorderRadius.circular(70),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.restart_alt_outlined,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
