import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/categories/views/add_new_category_view.dart';

class CustomAddCategoryButton extends StatelessWidget {
  const CustomAddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddNewCategoryView()),
        ),
        icon: const Icon(
          size: 24,
          Icons.add_rounded,
          fontWeight: FontWeight.w500,
          color: AppColors.icon,
        ),
      ),
    );
  }
}
