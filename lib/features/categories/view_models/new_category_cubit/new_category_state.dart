import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';

sealed class NewCategoryState {
  const NewCategoryState({
    required this.name,
    required this.selectedIcon,
    required this.selectedColor,
    required this.selectedType,
    required this.icons,
    required this.currentPageIndex,
  });

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
  });
}

class NewCategoryInitial extends NewCategoryState {
  const NewCategoryInitial({
    super.name = '',
    super.selectedIcon,
    super.selectedColor,
    super.selectedType,
    required super.icons,
    super.currentPageIndex = 0,
  });

  factory NewCategoryInitial.initial() {
    return NewCategoryInitial(icons: AppIcons.icons);
  }

  @override
  NewCategoryInitial copyWith({
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
    return NewCategoryInitial(
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

class NewCategoryLoading extends NewCategoryState {
  const NewCategoryLoading({
    required super.name,
    required super.selectedIcon,
    required super.selectedColor,
    required super.selectedType,
    required super.icons,
    required super.currentPageIndex,
  });

  @override
  NewCategoryLoading copyWith({
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
    return NewCategoryLoading(
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

class NewCategorySuccess extends NewCategoryState {
  const NewCategorySuccess({
    required super.name,
    required super.selectedIcon,
    required super.selectedColor,
    required super.selectedType,
    required super.icons,
    required super.currentPageIndex,
  });

  @override
  NewCategorySuccess copyWith({
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
    return NewCategorySuccess(
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

class NewCategoryFailure extends NewCategoryState {
  const NewCategoryFailure({
    required this.errorMessage,
    required super.name,
    required super.selectedIcon,
    required super.selectedColor,
    required super.selectedType,
    required super.icons,
    required super.currentPageIndex,
  });

  final String errorMessage;

  @override
  NewCategoryFailure copyWith({
    String? name,
    CategoryIcon? selectedIcon,
    Color? selectedColor,
    String? selectedType,
    List<CategoryIcon>? icons,
    int? currentPageIndex,
    bool clearSelectedIcon = false,
    bool clearSelectedColor = false,
    bool clearSelectedType = false,
    String? errorMessage,
  }) {
    return NewCategoryFailure(
      errorMessage: errorMessage ?? this.errorMessage,
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
