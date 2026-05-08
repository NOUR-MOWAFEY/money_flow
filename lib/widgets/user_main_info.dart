import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/widgets/reset_button.dart';
import 'package:money_flow/widgets/user_image.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: UserImage(),

      title: Text(
        HiveService.userName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.white,
        ),
      ),

      trailing: ResetButton(),
    );
  }
}
