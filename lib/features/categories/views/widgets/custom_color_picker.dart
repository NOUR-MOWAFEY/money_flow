import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ColorPicker(
        pickerColor: selectedColor,
        onColorChanged: onColorChanged,
        enableAlpha: false,
        hexInputBar: true,
        paletteType: PaletteType.hueWheel,
        pickerAreaBorderRadius: BorderRadius.circular(20),
        displayThumbColor: true,
        pickerAreaHeightPercent: 0.8,
        labelTypes: const [],
      ),
    );
  }
}
