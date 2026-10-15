import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/animations/dialog_open_animation.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/category_icon_picker_dialog.dart';

class NewCategoryIconButton extends StatelessWidget {
  const NewCategoryIconButton({
    super.key,
    this.icon,
    this.onTap,
  });

  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Icon: '),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap ??
              () async {
                FocusManager.instance.primaryFocus?.unfocus();

                final cubit = context.read<NewCategoryCubit>();

                await showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: const DialogOpenAnimation(
                      child: CategoryIconPickerDialog(),
                    ),
                  ),
                );
              },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.black1,
            ),
            child: Center(
              child: _buildIcon(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (icon != null) {
      return Icon(
        icon,
        size: 28,
        color: Colors.white,
      );
    }

    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) => Icon(
        state.selectedIcon?.icon ?? Icons.style_rounded,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
