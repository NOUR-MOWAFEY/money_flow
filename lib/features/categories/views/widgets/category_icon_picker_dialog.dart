import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_search_bar.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/icon_picker_alert_dialog_footer.dart';
import 'package:money_flow/features/categories/views/widgets/icon_picker_page_view.dart';

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
            _IconSearchBar(),

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

class _IconSearchBar extends StatelessWidget {
  const _IconSearchBar();

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      hint: 'Search for icons',
      onChanged: context.read<NewCategoryCubit>().searchIcons,
    );
  }
}
