import 'package:flutter/material.dart';

abstract final class AppDimensions {
  static const double viewPadding = 20;
  static const double screenVerticalPadding = 16;

  static const double viewBottomSpace = 30;
  static const double viewBottomSpaceWithFlaoting = 90;
  static const double viewTopSpace = 30;
  static const double chartSpacing = 20;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: viewPadding,
    vertical: screenVerticalPadding,
  );
}
