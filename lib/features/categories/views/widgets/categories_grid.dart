import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_cubit.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_state.dart';
import 'package:money_flow/features/categories/views/edit_category_view.dart';
import 'package:money_flow/features/categories/views/widgets/category_item.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key, required this.category});

  final ValueNotifier<CategoryModel?> category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1,
            maxCrossAxisExtent: 100,
          ),

          itemCount: state.categories.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              category.value = state.categories[index];
              Navigator.pop(context);
            },

            onLongPress: () {
              final selectedCategory = state.categories[index];
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

            child: CategoryItem(category: state.categories[index]),
          ),
        );
      },
    );
  }
}
