import 'package:money_flow/constants/app_icons.dart';
import 'package:money_flow/models/category_icon.dart';

class IconPickerState {
  const IconPickerState({
    required this.icons,
    required this.selectedIcon,
    required this.currentPageIndex,
  });

  factory IconPickerState.initial() {
    return IconPickerState(
      icons: AppIcons.icons,
      selectedIcon: null,
      currentPageIndex: 0,
    );
  }

  final List<CategoryIcon> icons;
  final CategoryIcon? selectedIcon;
  final int currentPageIndex;

  static const int iconsPerPage = 9;

  int get totalPages => (icons.length / iconsPerPage).ceil();

  IconPickerState copyWith({
    List<CategoryIcon>? icons,
    CategoryIcon? selectedIcon,
    int? currentPageIndex,
    bool clearSelectedIcon = false,
  }) {
    return IconPickerState(
      icons: icons ?? this.icons,
      selectedIcon: clearSelectedIcon
          ? null
          : selectedIcon ?? this.selectedIcon,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}

