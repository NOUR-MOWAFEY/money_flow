import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/core/widgets/custom_text_form_field.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/views/categories_view.dart';

class RecurringCategoryField extends StatelessWidget {
  const RecurringCategoryField({
    super.key,
    required this.transactionType,
    required this.category,
  });

  final ValueNotifier<CategoryType> transactionType;
  final ValueNotifier<CategoryModel?> category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Category: ',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 12),

        ValueListenableBuilder<CategoryModel?>(
          valueListenable: category,
          builder: (context, currentCategory, _) {
            return ValueListenableBuilder<CategoryType>(
              valueListenable: transactionType,
              builder: (context, currentType, _) {
                return CustomTextFormFiled(
                  icon:
                      currentCategory?.icon ??
                      AppCategories.defaultCategory.icon,
                  title: currentCategory?.title ?? 'Select',
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 18,
                  ),
                  isNormalTextField: true,
                  centerText: false,
                  isEnabled: false,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriesView(
                          type: currentType,
                          category: category,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
