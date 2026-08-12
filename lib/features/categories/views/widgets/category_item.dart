import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: category.color,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, color: Colors.white, size: 28),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              category.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
