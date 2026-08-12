import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';

class NewCategoryState {
  const NewCategoryState({
    required this.name,
    required this.selectedIcon,
    required this.selectedColor,
    required this.selectedType,
    required this.icons,
    required this.currentPageIndex,
  });

  factory NewCategoryState.initial() {
    return NewCategoryState(
      name: '',
      selectedIcon: null,
      selectedColor: null,
      selectedType: null,
      icons: AppIcons.icons,
      currentPageIndex: 0,
    );
  }

  final String name;
  final CategoryIcon? selectedIcon;
  final Color? selectedColor;
  final String? selectedType;

  // Icon picker state
  final List<CategoryIcon> icons;
  final int currentPageIndex;

  static const int iconsPerPage = 9;

  int get totalPages {
    if (icons.isEmpty) return 1;
    return (icons.length / iconsPerPage).ceil();
  }

  NewCategoryState copyWith({
    String? name,
    CategoryIcon? selectedIcon,
    Color? selectedColor,
    String? selectedType,
    List<CategoryIcon>? icons,
    int? currentPageIndex,
    bool clearSelectedIcon = false,
    bool clearSelectedColor = false,
    bool clearSelectedType = false,
  }) {
    return NewCategoryState(
      name: name ?? this.name,
      selectedIcon: clearSelectedIcon
          ? null
          : selectedIcon ?? this.selectedIcon,
      selectedColor: clearSelectedColor
          ? null
          : selectedColor ?? this.selectedColor,
      selectedType: clearSelectedType
          ? null
          : selectedType ?? this.selectedType,
      icons: icons ?? this.icons,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}
