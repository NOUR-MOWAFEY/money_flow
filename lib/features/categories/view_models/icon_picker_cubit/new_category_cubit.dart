import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_state.dart';

class NewCategoryCubit extends Cubit<NewCategoryState> {
  NewCategoryCubit() : super(NewCategoryState.initial());

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

  void reset() {
    emit(NewCategoryState.initial());
  }
}
