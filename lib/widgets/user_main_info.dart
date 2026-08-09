import 'package:flutter/material.dart';
import 'package:money_flow/services/hive_service.dart';
import 'package:money_flow/widgets/custom_text.dart';
import 'package:money_flow/widgets/reset_button.dart';
import 'package:money_flow/widgets/user_image.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 35),

      leading: const UserImage(),

      title: CustomText(
        HiveService.userName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      trailing: const ResetButton(),
    );
  }
}
