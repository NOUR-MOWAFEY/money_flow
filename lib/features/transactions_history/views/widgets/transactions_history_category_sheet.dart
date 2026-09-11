import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class TransactionsHistoryCategorySheet extends StatelessWidget {
  const TransactionsHistoryCategorySheet({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<CategoryModel> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onSelected;

  static Future<void> show(
    BuildContext context, {
    required List<CategoryModel> categories,
    required String? selectedCategory,
    required ValueChanged<String?> onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black1,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) =>
            TransactionsHistoryCategorySheet(
              categories: categories,
              selectedCategory: selectedCategory,
              onSelected: onSelected,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Unique categories by title
    final uniqueCategories = <String, CategoryModel>{};
    for (final cat in categories) {
      uniqueCategories.putIfAbsent(cat.title, () => cat);
    }
    final categoryList = uniqueCategories.values.toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CustomText(
              'Filter by Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.black2,
                      child: Icon(Icons.apps, color: Colors.white70, size: 20),
                    ),
                    title: CustomText(
                      'All Categories',
                      style: TextStyle(
                        fontWeight: selectedCategory == null
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: selectedCategory == null
                            ? AppColors.primary
                            : Colors.white,
                      ),
                    ),
                    trailing: selectedCategory == null
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(context);
                      onSelected(null);
                    },
                  ),
                  const Divider(color: Colors.white12),
                  ...categoryList.map((cat) {
                    final isSelected = selectedCategory == cat.title;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: cat.color.categoryContainerColor,
                        child: Icon(
                          cat.icon,
                          color: cat.color.categoryIconColor,
                          size: 18,
                        ),
                      ),
                      title: CustomText(
                        cat.title,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected ? AppColors.primary : Colors.white,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                            )
                          : null,
                      onTap: () {
                        Navigator.pop(context);
                        onSelected(cat.title);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
