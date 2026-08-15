import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/views/widgets/custom_color_picker.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_color_picker_dialog_footer.dart';

class EditCategoryColorPickerDialog extends StatefulWidget {
  const EditCategoryColorPickerDialog({super.key, required this.initialColor});

  final Color initialColor;

  @override
  State<EditCategoryColorPickerDialog> createState() =>
      _EditCategoryColorPickerDialogState();
}

class _EditCategoryColorPickerDialogState
    extends State<EditCategoryColorPickerDialog> {
  late final ValueNotifier<Color> tempColor;

  @override
  void initState() {
    super.initState();
    tempColor = ValueNotifier(widget.initialColor);
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
          ValueListenableBuilder<Color>(
            valueListenable: tempColor,
            builder: (context, color, _) {
              return CustomColorPicker(
                selectedColor: color,
                onColorChanged: (newColor) => tempColor.value = newColor,
              );
            },
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<Color>(
            valueListenable: tempColor,
            builder: (_, color, _) =>
                EditCategoryColorPickerDialogFooter(currentColor: color),
          ),
        ],
      ),
    );
  }
}
