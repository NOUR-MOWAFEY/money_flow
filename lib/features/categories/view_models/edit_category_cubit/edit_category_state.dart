import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

sealed class EditCategoryState {
  const EditCategoryState({
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

  EditCategoryState copyWith({
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

class EditCategoryInitial extends EditCategoryState {
  const EditCategoryInitial({
    required super.name,
    required super.selectedIcon,
    required super.selectedColor,
    required super.selectedType,
    required super.icons,
    super.currentPageIndex = 0,
  });

  factory EditCategoryInitial.fromCategory(CategoryModel category) {
    final matchingIcon = AppIcons.icons.firstWhere(
      (i) => i.icon == category.icon,
      orElse: () => CategoryIcon(icon: category.icon, name: ''),
    );

    final selectedIndex = AppIcons.icons.indexOf(matchingIcon);
    final pageIndex = selectedIndex == -1
        ? 0
        : selectedIndex ~/ EditCategoryState.iconsPerPage;

    final typeName = StringUtils.capitalizeFirstLetter(
      category.categoryType.name,
    );

    return EditCategoryInitial(
      name: category.title,
      selectedIcon: matchingIcon,
      selectedColor: category.color,
      selectedType: typeName,
      icons: AppIcons.icons,
      currentPageIndex: pageIndex,
    );
  }

  @override
  EditCategoryInitial copyWith({
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
    return EditCategoryInitial(
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

class EditCategoryLoading extends EditCategoryState {
  const EditCategoryLoading({
    required super.name,
    required super.selectedIcon,
    required super.selectedColor,
    required super.selectedType,
    required super.icons,
    required super.currentPageIndex,
  });

  @override
  EditCategoryLoading copyWith({
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
    return EditCategoryLoading(
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

class EditCategorySuccess extends EditCategoryState {
  const EditCategorySuccess({
    required super.name,
    required super.selectedIcon,
    required super.selectedColor,
    required super.selectedType,
    required super.icons,
    required super.currentPageIndex,
  });

  @override
  EditCategorySuccess copyWith({
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
    return EditCategorySuccess(
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

class EditCategoryFailure extends EditCategoryState {
  const EditCategoryFailure({
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
  EditCategoryFailure copyWith({
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
    return EditCategoryFailure(
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
