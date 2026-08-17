import 'package:flutter/material.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/views/edit_category_view.dart';
import 'package:money_flow/features/categories/views/widgets/category_item.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    super.key,
    required this.category,
    required this.categories,
  });

  final ValueNotifier<CategoryModel?> category;
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: 1,
        maxCrossAxisExtent: 100,
      ),

      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          category.value = categories[index];
          Navigator.pop(context);
        },

        onLongPress: () {
          final selectedCategory = categories[index];
          if (selectedCategory.isDefault) {
            ShowToastification.warning(
              context,
              'Default categories cannot be edited',
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditCategoryView(category: selectedCategory),
            ),
          );
        },

        child: CategoryItem(category: categories[index]),
      ),
    );
  }
}
