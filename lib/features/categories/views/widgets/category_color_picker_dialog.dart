import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/color_picker_alert_dialog_footer.dart';
import 'package:money_flow/features/categories/views/widgets/custom_color_picker.dart';

class CategoryColorPickerDialog extends StatefulWidget {
  const CategoryColorPickerDialog({super.key});

  @override
  State<CategoryColorPickerDialog> createState() =>
      _CategoryColorPickerDialogState();
}

class _CategoryColorPickerDialogState extends State<CategoryColorPickerDialog> {
  late final ValueNotifier<Color> tempColor;

  @override
  void initState() {
    super.initState();
    tempColor = ValueNotifier(
      context.read<NewCategoryCubit>().state.selectedColor ?? Colors.white,
    );
  }

  @override
  void dispose() {
    tempColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bg,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      title: const CustomText('Choose a color'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomColorPicker(
            selectedColor: tempColor.value,
            onColorChanged: (color) => tempColor.value = color,
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<Color>(
            valueListenable: tempColor,
            builder: (_, color, _) =>
                ColorPickerAlertDialogFooter(currentColor: color),
          ),
        ],
      ),
    );
  }
}
