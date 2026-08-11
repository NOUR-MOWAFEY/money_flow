import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/constants/app_icons.dart';
import 'package:money_flow/models/category_icon.dart';

import 'icon_picker_state.dart';

class IconPickerCubit extends Cubit<IconPickerState> {
  IconPickerCubit() : super(IconPickerState.initial());

  void searchIcons(String query) {
    final filteredIcons = query.trim().isEmpty
        ? AppIcons.icons
        : AppIcons.searchIcons(query);

    emit(
      state.copyWith(
        icons: filteredIcons,
        currentPageIndex: 0,
        clearSelectedIcon: true,
      ),
    );
  }

  void selectIcon(CategoryIcon icon) {
    emit(state.copyWith(selectedIcon: icon));
  }

  void changePage(int index) {
    if (state.currentPageIndex == index) {
      return;
    }

    emit(state.copyWith(currentPageIndex: index));
  }

  void reset() {
    emit(IconPickerState.initial());
  }
}
