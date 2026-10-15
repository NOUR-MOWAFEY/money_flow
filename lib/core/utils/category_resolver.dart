import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';

class CategoryResolver {
  /// Resolves the most appropriate [CategoryModel] for a transaction.
  ///
  /// Matches predefined and custom categories first, then resolves
  /// environment metadata (icon & color) for environment-related transactions
  /// such as "Remaining from `<Name>`" or "Environment: `<Name>`".
  static CategoryModel findCategory({
    required String title,
    required bool isExpense,
    required List<CategoryModel> allCategories,
  }) {
    final targetType = isExpense ? CategoryType.expenses : CategoryType.income;

    // 1. Direct match with allCategories
    for (final category in allCategories) {
      if (category.title.toLowerCase() == title.toLowerCase() &&
          category.categoryType == targetType) {
        return category;
      }
    }

    // 2. Check if it's an Environment / Remaining transaction
    final lowerTitle = title.toLowerCase();
    String? envName;
    if (lowerTitle.startsWith('remaining from ')) {
      envName = title.substring('remaining from '.length).trim();
    } else if (lowerTitle.startsWith('remaining of ')) {
      envName = title.substring('remaining of '.length).trim();
    } else if (lowerTitle.startsWith('environment: ')) {
      envName = title.substring('environment: '.length).trim();
    } else if (lowerTitle.startsWith('top-up: ')) {
      envName = title.substring('top-up: '.length).trim();
    }

    if (envName != null && envName.isNotEmpty) {
      try {
        final environments = HiveService.instance.getEnvironments();
        final match = environments.where(
          (e) => e.name.toLowerCase() == envName!.toLowerCase(),
        );
        if (match.isNotEmpty) {
          final env = match.first;
          return CategoryModel(
            title: title,
            // ignore: non_const_argument_for_const_parameter
            icon: IconData(env.iconCodePoint, fontFamily: 'MaterialIcons'),
            color: Color(env.colorValue),
            categoryType: targetType,
          );
        }
      } catch (_) {}
    }

    // 3. Fallback for remaining funds
    if (lowerTitle.contains('remaining')) {
      return CategoryModel(
        title: title,
        icon: Icons.savings_rounded,
        color: const Color(0xFF2E7D32),
        categoryType: targetType,
      );
    }

    // 4. Fallback for environment allocations / top-ups
    if (lowerTitle.startsWith('environment:') ||
        lowerTitle.startsWith('top-up:')) {
      return CategoryModel(
        title: title,
        icon: Icons.layers_rounded,
        color: AppColors.primary,
        categoryType: targetType,
      );
    }

    // 5. Default fallback
    return AppCategories.defaultCategory;
  }
}
