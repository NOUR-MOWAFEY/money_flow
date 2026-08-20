import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/home/views/widgets/user_image.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.viewPadding),
      child: ListTile(
        contentPadding: EdgeInsets.only(bottom: 16),

        leading: UserImage(),

        title: Column(
          crossAxisAlignment: .start,
          children: [
            CustomText('Hello,', style: TextStyle(fontSize: 14)),

            CustomText(
              'Nour Mowafey',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),

        // trailing: const ResetButton(),
      ),
    );
  }
}
