import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/home/views/widgets/user_image.dart';
import 'package:money_flow/features/profile/views/profile_view.dart';

class UserGreetingSection extends StatelessWidget {
  const UserGreetingSection({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, _) {
        final user = HiveService.getUserModel();
        final name = (user != null && user.name.trim().isNotEmpty)
            ? user.name.trim()
            : 'User';

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
          ),
          child: InkWell(
            onTap: onTap ??
                () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (_) => const ProfileView()),
                  );
                },
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              contentPadding: const EdgeInsets.only(bottom: 16),
              leading: const UserImage(radius: 24),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText('Hello,', style: TextStyle(fontSize: 14)),
                  CustomText(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
