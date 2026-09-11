import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ProfileImagePickerSheet extends StatelessWidget {
  const ProfileImagePickerSheet({
    super.key,
    required this.hasImage,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  final bool hasImage;
  final ValueChanged<ImageSource> onPickImage;
  final VoidCallback onRemoveImage;

  static Future<void> show(
    BuildContext context, {
    required bool hasImage,
    required ValueChanged<ImageSource> onPickImage,
    required VoidCallback onRemoveImage,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => ProfileImagePickerSheet(
        hasImage: hasImage,
        onPickImage: onPickImage,
        onRemoveImage: onRemoveImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CustomText(
              'Profile Photo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.black2,
                child: Icon(Icons.photo_camera_rounded, color: Colors.white, size: 20),
              ),
              title: const CustomText(
                'Take Photo',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                onPickImage(ImageSource.camera);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.black2,
                child: Icon(Icons.photo_library_rounded, color: Colors.white, size: 20),
              ),
              title: const CustomText(
                'Choose from Gallery',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                onPickImage(ImageSource.gallery);
              },
            ),
            if (hasImage) ...[
              const Divider(color: Colors.white12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.error.withAlpha(40),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.error,
                    size: 20,
                  ),
                ),
                title: const CustomText(
                  'Remove Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onRemoveImage();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
