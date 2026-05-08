import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/views/categories_view.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({super.key, required this.transactionType});

  final TransactionType transactionType;

  static final ValueNotifier<CategoryModel> _category = ValueNotifier(
    CategoryModel(icon: Icons.category_rounded, title: 'Category'),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CategoryModel>(
      valueListenable: _category,
      builder: (BuildContext context, CategoryModel value, Widget? child) =>
          CustomTextFormFiled(
            icon: _category.value.icon,
            title: _category.value.title,
            isEnabled: false,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesView(
                    transactionType: transactionType,
                    category: _category,
                  ),
                ),
              );
            },
          ),
    );
  }
}
