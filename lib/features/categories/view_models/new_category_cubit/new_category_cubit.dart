import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';

class NewCategoryCubit extends Cubit<NewCategoryState> {
  NewCategoryCubit(this.hiveService) : super(NewCategoryInitial.initial()) {
    nameController.addListener(_onNameChanged);
  }

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
        : selectedIndex ~/ NewCategoryState.iconsPerPage;

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

  // save category to Hive
  Future<void> saveCategory() async {
    final error = validate();

    if (error != null) {
      log('Validation error: $error');
      emit(
        NewCategoryFailure(
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
        NewCategoryInitial(
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
      NewCategoryLoading(
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

      final category = CategoryModel(
        title: state.name.trim(),
        icon: state.selectedIcon!.icon,
        color: state.selectedColor!,
        categoryType: categoryType,
      );

      await hiveService.addCategory(category);
      log('Category saved: ${category.title}');

      emit(
        NewCategorySuccess(
          name: state.name,
          selectedIcon: state.selectedIcon,
          selectedColor: state.selectedColor,
          selectedType: state.selectedType,
          icons: state.icons,
          currentPageIndex: state.currentPageIndex,
        ),
      );
      reset();
    } catch (e) {
      log('Failed to save category: $e');
      emit(
        NewCategoryFailure(
          errorMessage: 'Failed to save category',
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
    if (state is! NewCategoryFailure) return;

    emit(
      NewCategoryInitial(
        name: state.name,
        selectedIcon: state.selectedIcon,
        selectedColor: state.selectedColor,
        selectedType: state.selectedType,
        icons: state.icons,
        currentPageIndex: state.currentPageIndex,
      ),
    );
  }

  void reset() {
    nameController.removeListener(_onNameChanged);
    nameController.clear();
    nameController.addListener(_onNameChanged);
    emit(NewCategoryInitial.initial());
  }

  @override
  Future<void> close() {
    nameController.removeListener(_onNameChanged);
    nameController.dispose();
    return super.close();
  }
}
