import 'package:flutter/cupertino.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class DeleteCategoryDialogHeader extends StatelessWidget {
  const DeleteCategoryDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          CupertinoIcons.exclamationmark_circle,
          size: 80,
          color: AppColors.error,
        ),

        SizedBox(height: 6),

        CustomText(
          'Are you sure ?',
          textAlign: .center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
