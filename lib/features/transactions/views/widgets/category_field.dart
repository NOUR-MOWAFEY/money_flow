import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/views/categories_view.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({
    super.key,
    required this.transactionType,
    required this.category,
  });

  final ValueNotifier<CategoryType> transactionType;
  final ValueNotifier<CategoryModel?> category;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CategoryModel?>(
      valueListenable: category,
      builder: (BuildContext context, CategoryModel? value, Widget? child) =>
          ValueListenableBuilder(
            valueListenable: transactionType,
            builder: (BuildContext context, value, Widget? child) =>
                CustomTextFormFiled(
                  icon:
                      category.value?.icon ??
                      AppCategories.defaultCategory.icon,
                  title:
                      category.value?.title ??
                      AppCategories.defaultCategory.title,
                  isEnabled: false,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriesView(
                          type: transactionType.value,
                          category: category,
                        ),
                      ),
                    );
                  },
                ),
          ),
    );
  }
}
