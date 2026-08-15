import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/categories/views/widgets/page_number_indicator.dart';

class IconPickerAlertDialogFooter extends StatelessWidget {
  const IconPickerAlertDialogFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        final pageText = state.totalPages == 0
            ? '0 / 0'
            : '${state.currentPageIndex + 1} / ${state.totalPages}';

        return SizedBox(
          height: 42,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageNumberIndicator(pageText: pageText),

              Row(
                children: [
                  CustomButton(
                    width: 90,
                    color: AppColors.secondaryColor,
                    title: 'Cancel',
                    textSize: 14,
                    onTap: () => Navigator.pop(context),
                  ),

                  const SizedBox(width: 8),

                  CustomButton(
                    width: 120,
                    textSize: 14,
                    title: 'Use',
                    onTap: state.selectedIcon == null
                        ? null
                        : () {
                            Navigator.pop(context, state.selectedIcon);
                          },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
