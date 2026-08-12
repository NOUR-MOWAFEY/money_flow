import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/icon_picker_cubit.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/views/widgets/icon_picker_alert_dialog.dart';

class NewCategoryIconButton extends StatelessWidget {
  const NewCategoryIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText('Icon: '),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => IconPickerCubit(),
                child: const IconPickerAlertDialog(),
              ),
            );
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondaryColor,
            ),
            child: const Icon(Icons.style_rounded, size: 28),
          ),
        ),
      ],
    );
  }
}
