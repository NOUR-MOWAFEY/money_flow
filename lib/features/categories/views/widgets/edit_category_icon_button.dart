import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/category_icon_picker_dialog.dart';

class EditCategoryIconButton extends StatelessWidget {
  const EditCategoryIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Icon: '),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();

            final editCubit = context.read<EditCategoryCubit>();
            final currentIcon = editCubit.state.selectedIcon;

            final selectedIcon = await showDialog<CategoryIcon>(
              context: context,
              builder: (context) => BlocProvider(
                create: (_) {
                  final pickerCubit = NewCategoryCubit(HiveService());
                  if (currentIcon != null) {
                    pickerCubit.selectIcon(currentIcon);
                    pickerCubit.resetIconPicker();
                  }
                  return pickerCubit;
                },
                child: const DialogOpenAnimation(
                  child: CategoryIconPickerDialog(),
                ),
              ),
            );

            if (selectedIcon != null) {
              editCubit.selectIcon(selectedIcon);
            }
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.black1,
            ),
            child: BlocBuilder<EditCategoryCubit, EditCategoryState>(
              builder: (context, state) => Icon(
                state.selectedIcon?.icon ?? Icons.style_rounded,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
