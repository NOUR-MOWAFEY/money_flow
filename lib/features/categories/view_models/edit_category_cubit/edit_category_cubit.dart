import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit(this.category, this.hiveService)
      : super(EditCategoryInitial.fromCategory(category)) {
    nameController.text = category.title;
    nameController.addListener(_onNameChanged);
  }

  final CategoryModel category;
  final HiveService hiveService;
  final TextEditingController nameController = TextEditingController();

  void _onNameChanged() {
    setName(nameController.text);
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void searchIcons(String query) {
    final filteredIcons = query.trim().isEmpty
        ? AppIcons.icons
        : AppIcons.searchIcons(query);

    emit(state.copyWith(icons: filteredIcons, currentPageIndex: 0));
  }

  void selectIcon(CategoryIcon icon) {
    emit(state.copyWith(selectedIcon: icon));
  }

  void resetIconPicker() {
    final selectedIcon = state.selectedIcon;

    if (selectedIcon == null) {
      emit(state.copyWith(icons: AppIcons.icons, currentPageIndex: 0));
      return;
    }

    final selectedIndex = AppIcons.icons.indexOf(selectedIcon);

    final pageIndex = selectedIndex == -1
        ? 0
        : selectedIndex ~/ EditCategoryState.iconsPerPage;

    emit(state.copyWith(icons: AppIcons.icons, currentPageIndex: pageIndex));
  }

  void selectColor(Color color) {
    emit(state.copyWith(selectedColor: color));
  }

  void selectType(String type) {
    emit(state.copyWith(selectedType: type));
  }

  void changePage(int index) {
    if (state.currentPageIndex == index) return;

    emit(state.copyWith(currentPageIndex: index));
  }

  // validate form fields
  String? validate() {
    if (state.name.trim().isEmpty) return 'Please enter a category name';
    if (state.selectedIcon == null) return 'Please select an icon';
    if (state.selectedColor == null) return 'Please select a color';
    if (state.selectedType == null) return 'Please select a type';
    return null;
  }

  // update category in Hive
  Future<void> updateCategory() async {
    if (category.isDefault) {
      emit(
        EditCategoryFailure(
          errorMessage: 'Default categories cannot be modified',
          name: state.name,
          selectedIcon: state.selectedIcon,
          selectedColor: state.selectedColor,
          selectedType: state.selectedType,
          icons: state.icons,
          currentPageIndex: state.currentPageIndex,
        ),
      );
      return;
    }

    final error = validate();

    if (error != null) {
      log('Validation error: $error');
      emit(
        EditCategoryFailure(
          errorMessage: error,
          name: state.name,
          selectedIcon: state.selectedIcon,
          selectedColor: state.selectedColor,
          selectedType: state.selectedType,
          icons: state.icons,
          currentPageIndex: state.currentPageIndex,
        ),
      );
      emit(
        EditCategoryInitial(
          name: state.name,
          selectedIcon: state.selectedIcon,
          selectedColor: state.selectedColor,
          selectedType: state.selectedType,
          icons: state.icons,
          currentPageIndex: state.currentPageIndex,
        ),
      );
      return;
    }

    emit(
      EditCategoryLoading(
        name: state.name,
        selectedIcon: state.selectedIcon,
        selectedColor: state.selectedColor,
        selectedType: state.selectedType,
        icons: state.icons,
        currentPageIndex: state.currentPageIndex,
      ),
    );

    try {
      final categoryType = state.selectedType!.toLowerCase() == 'expenses'
          ? CategoryType.expenses
          : CategoryType.income;

      await hiveService.updateCategory(
        category,
        title: state.name.trim(),
        icon: state.selectedIcon!.icon,
        color: state.selectedColor!,
        categoryType: categoryType,
      );

      log('Category updated: ${category.title}');

      emit(
        EditCategorySuccess(
          name: state.name,
          selectedIcon: state.selectedIcon,
          selectedColor: state.selectedColor,
          selectedType: state.selectedType,
          icons: state.icons,
          currentPageIndex: state.currentPageIndex,
        ),
      );
    } catch (e) {
      log('Failed to update category: $e');
      emit(
        EditCategoryFailure(
          errorMessage: 'Failed to update category',
          name: state.name,
          selectedIcon: state.selectedIcon,
          selectedColor: state.selectedColor,
          selectedType: state.selectedType,
          icons: state.icons,
          currentPageIndex: state.currentPageIndex,
        ),
      );
    }
  }

  void clearError() {
    if (state is! EditCategoryFailure) return;

    emit(
      EditCategoryInitial(
        name: state.name,
        selectedIcon: state.selectedIcon,
        selectedColor: state.selectedColor,
        selectedType: state.selectedType,
        icons: state.icons,
        currentPageIndex: state.currentPageIndex,
      ),
    );
  }

  @override
  Future<void> close() {
    nameController.removeListener(_onNameChanged);
    nameController.dispose();
    return super.close();
  }
}
