import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/views/widgets/category_list_view_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,

      itemBuilder: (context, index) => CategoryListViewItem(
        isLastItem: categories.length - 1 == index,

        category: categories[index],
      ),
    );
  }
}
