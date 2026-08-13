import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/categories/views/widgets/icon_picker_alert_dialog_footer.dart';
import 'package:money_flow/features/categories/views/widgets/icon_picker_page_view.dart';
import 'package:money_flow/features/categories/views/widgets/icon_search_field.dart';

class CategoryIconPickerDialog extends StatelessWidget {
  const CategoryIconPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: AppColors.bg,
      insetPadding: EdgeInsets.symmetric(horizontal: 12),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconSearchField(),

            SizedBox(height: 16),

            IconPickerPageView(),

            SizedBox(height: 16),

            IconPickerAlertDialogFooter(),
          ],
        ),
      ),
    );
  }
}
