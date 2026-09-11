import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class ProfileSaveButton extends StatelessWidget {
  const ProfileSaveButton({
    super.key,
    required this.isSaving,
    required this.onTap,
  });

  final bool isSaving;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: isSaving ? '' : 'Save Changes',
      onTap: isSaving ? null : onTap,
      child: isSaving
          ? const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.bg,
                ),
              ),
            )
          : null,
    );
  }
}
