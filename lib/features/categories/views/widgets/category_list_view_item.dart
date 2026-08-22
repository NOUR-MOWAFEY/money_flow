import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/views/edit_category_view.dart';

class CategoryListViewItem extends StatelessWidget {
  const CategoryListViewItem({
    super.key,
    required this.isLastItem,
    required this.category,
  });
  final bool isLastItem;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: 12,
        bottom: isLastItem ? AppDimensions.viewBottomSpace : 0,
      ),

      child: _CategoryListViewItemContainer(
        category: category,
        child: Row(
          children: [
            // flag
            _CategoryIcon(category: category),

            const SizedBox(width: 12),

            // name + type
            _CategoryTitles(category: category),

            const Spacer(),

            // check icon
            const FaIcon(FontAwesomeIcons.chevronRight, size: 16),

            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class _CategoryListViewItemContainer extends StatelessWidget {
  const _CategoryListViewItemContainer({
    required this.category,
    required this.child,
  });

  final CategoryModel category;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditCategoryView(category: category),
        ),
      ),

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black1,

          border: Border.all(color: Colors.transparent, width: 2),

          borderRadius: BorderRadius.circular(20),
        ),

        padding: const EdgeInsets.all(12),

        child: child,
      ),
    );
  }
}

class _CategoryTitles extends StatelessWidget {
  const _CategoryTitles({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        // name
        CustomText(
          category.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        // type
        CustomText(
          StringUtils.capitalizeFirstLetter(category.categoryType.name),
        ),
      ],
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: category.color.categoryContainerColor,
      child: Icon(category.icon, color: category.color.categoryIconColor),
    );
  }
}
