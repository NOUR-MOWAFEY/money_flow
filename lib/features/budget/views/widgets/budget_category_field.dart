import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';
import 'package:money_flow/features/budget/views/budget_categories_view.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class BudgetCategoryField extends StatelessWidget {
  const BudgetCategoryField({
    super.key,
    required this.category,
    required this.onCategorySelected,
    this.excludedTitles = const [],
  });

  final CategoryModel? category;
  final ValueChanged<CategoryModel> onCategorySelected;
  final List<String> excludedTitles;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFiled(
      icon: category?.icon ?? AppCategories.defaultCategory.icon,
      title: category?.title ?? 'Select Category',
      isEnabled: false,
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final selected = await Navigator.push<CategoryModel>(
          context,
          MaterialPageRoute(
            builder: (context) => BudgetCategoriesView(
              selectedCategory: category,
              excludedTitles: excludedTitles,
              onSelected: (selectedCategory) {
                Navigator.pop(context, selectedCategory);
              },
            ),
          ),
        );

        if (selected != null) {
          onCategorySelected(selected);
        }
      },
    );
  }
}
