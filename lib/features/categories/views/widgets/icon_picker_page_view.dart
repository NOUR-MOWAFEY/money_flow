import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_icons.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';
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

    final cubit = context.read<NewCategoryCubit>();

    cubit.resetIconPicker();

    final initialPage = cubit.state.currentPageIndex;

    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 345,
      child: BlocConsumer<NewCategoryCubit, NewCategoryState>(
        listenWhen: (previous, current) => previous.icons != current.icons,

        listener: (context, state) {
          final isSearching = state.icons.length != AppIcons.icons.length;

          if (isSearching && _pageController.hasClients) {
            _pageController.jumpToPage(0);
          }
        },

        builder: (context, state) {
          return ExpandablePageView.builder(
            controller: _pageController,
            itemCount: state.totalPages,
            onPageChanged: context.read<NewCategoryCubit>().changePage,
            itemBuilder: (context, pageIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: CategoryIconsGrid(
                  pageIndex: pageIndex,
                  icons: state.icons,
                  selectedIcon: state.selectedIcon,
                ),
              );
            },
          );
        },
      ),
    );
  }
}



