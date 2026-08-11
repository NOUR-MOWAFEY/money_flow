import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/cubits/cubit/icon_picker_cubit.dart';
import 'package:money_flow/cubits/cubit/icon_picker_state.dart';
import 'package:money_flow/widgets/category_icons_grid.dart';

class IconPickerPageView extends StatelessWidget {
  const IconPickerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IconPickerCubit, IconPickerState>(
      builder: (context, state) {
        final pageCount = state.totalPages == 0 ? 1 : state.totalPages;

        return ExpandablePageView.builder(
          itemCount: pageCount,
          onPageChanged: context.read<IconPickerCubit>().changePage,
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
