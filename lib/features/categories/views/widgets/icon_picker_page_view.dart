import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/category_icons_grid.dart';

class IconPickerPageView extends StatefulWidget {
  const IconPickerPageView({super.key});

  @override
  State<IconPickerPageView> createState() => _IconPickerPageViewState();
}

class _IconPickerPageViewState extends State<IconPickerPageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    context.read<NewCategoryCubit>().resetIconPicker();

    final initialPage = context.read<NewCategoryCubit>().state.currentPageIndex;

    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        return ExpandablePageView.builder(
          controller: _pageController,
          itemCount: state.totalPages,
          onPageChanged: context.read<NewCategoryCubit>().changePage,
          itemBuilder: (context, pageIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: CategoryIconsGrid(
                pageIndex: pageIndex,
                icons: state.icons,
                selectedIcon: state.selectedIcon,
              ),
            );
          },
        );
      },
    );
  }
}
