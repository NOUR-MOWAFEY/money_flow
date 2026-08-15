import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';
import 'package:money_flow/features/categories/views/widgets/pick_icon_item.dart';

class CategoryIconsGrid extends StatelessWidget {
  const CategoryIconsGrid({
    super.key,
    required this.pageIndex,
    required this.icons,
    required this.selectedIcon,
  });

  static const int iconsPerPage = 9;

  final int pageIndex;
  final List<CategoryIcon> icons;
  final CategoryIcon? selectedIcon;

  @override
  Widget build(BuildContext context) {
    final startIndex = pageIndex * iconsPerPage;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: iconsPerPage,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final currentIndex = startIndex + index;

        if (currentIndex >= icons.length) {
          return const SizedBox();
        }

        final icon = icons[currentIndex];

        return GestureDetector(
          onTap: () {
            context.read<NewCategoryCubit>().selectIcon(icon);
          },
          child: PickIconItem(
            item: icon,
            isSelected: selectedIcon?.name == icon.name,
          ),
        );
      },
    );
  }
}
