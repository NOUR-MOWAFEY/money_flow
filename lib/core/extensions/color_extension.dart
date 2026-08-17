import 'package:flutter/material.dart';

extension CategoryColorExtension on Color {
  /// Ensures the container has a visible, rich dark tone that never disappears into the app background.
  Color get categoryContainerColor {
    // If transparent (e.g. default/deleted fallback), keep transparent
    if (a == 0) return Colors.transparent;

    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness(0.17)
        .withSaturation((hsl.saturation * 0.4).clamp(0.25, 0.85))
        .toColor();
  }

  /// Ensures the icon is always bright, clear, and visible on dark backgrounds.
  Color get categoryIconColor {
    if (a == 0) return Colors.white;

    final hsl = HSLColor.fromColor(this);
    // If the color is too dark, lift its lightness so it remains vibrant
    if (hsl.lightness < 0.55) {
      return hsl.withLightness(0.7).withSaturation(0.7).toColor();
    }
    return this;
  }
}
