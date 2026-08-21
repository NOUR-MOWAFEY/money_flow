import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/extensions/color_extension.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class SelectableCategoryItem extends StatelessWidget {
  const SelectableCategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
  });

  final CategoryModel category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? category.color.categoryContainerColor
            : AppColors.black1,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? category.color.categoryIconColor
              : Colors.transparent,
          width: 2,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            category.icon,
            color: category.color.categoryIconColor,
            size: 28,
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: FittedBox(
              fit: .scaleDown,

              child: CustomText(
                category.title,
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
