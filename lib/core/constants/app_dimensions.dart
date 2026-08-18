import 'package:flutter/material.dart';

abstract final class AppDimensions {
  static const double viewPadding = 20;
  static const double screenVerticalPadding = 16;

  static const double viewBottomSpace = 140;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: viewPadding,
    vertical: screenVerticalPadding,
  );
}
