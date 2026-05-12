import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/views/categories_view.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({
    super.key,
    required this.transactionType,
    required this.category,
  });

  final ValueNotifier<TransactionType> transactionType;
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
                          transactionType: transactionType.value,
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
