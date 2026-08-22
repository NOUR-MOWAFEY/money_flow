import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/core/widgets/selectable_category_item.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class BudgetCategoriesView extends StatelessWidget {
  const BudgetCategoriesView({
    super.key,
    required this.onSelected,
    this.selectedCategory,
    this.excludedTitles = const [],
  });

  final ValueChanged<CategoryModel> onSelected;
  final CategoryModel? selectedCategory;
  final List<String> excludedTitles;

  @override
  Widget build(BuildContext context) {
    final hiveService = HiveService();
    final categories = [
      ...AppCategories.expenseCategories,
      ...hiveService.getExpenseCategories(),
    ].where((category) => !excludedTitles.contains(category.title)).toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Select Category'),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.viewPadding,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1,
            crossAxisCount: 3,
          ),

          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = categories[index];
            final isSelected = selectedCategory?.title == category.title;

            return GestureDetector(
              onTap: () => onSelected(category),
              child: SelectableCategoryItem(
                category: category,
                isSelected: isSelected,
              ),
            );
          },
        ),
      ),
    );
  }
}
