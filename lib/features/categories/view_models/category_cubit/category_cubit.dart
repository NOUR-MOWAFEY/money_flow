import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.hiveService) : super(CategoriesState.initial());

  final HiveService hiveService;
  StreamSubscription? _categoriesSubscription;
  CategoryType? _currentType;

  // fetch all categories
  // Future<void> getCategories() async {
  //   emit(state.copyWith(status: CategoriesStatus.loading));

  //   try {
  //     final categories = hiveService.getAllCategories();
  //     emit(
  //       state.copyWith(
  //         status: CategoriesStatus.loaded,
  //         categories: categories,
  //       ),
  //     );
  //   } catch (e) {
  //     log('Failed to load categories: $e');
  //     emit(
  //       state.copyWith(
  //         status: CategoriesStatus.error,
  //         errorMessage: 'Failed to load categories',
  //       ),
  //     );
  //   }
  // }

  // fetch categories filtered by type
  Future<void> getCategoriesByType(CategoryType type) async {
    _currentType = type;

    // subscribe once to box changes
    _categoriesSubscription ??= hiveService.watchCategories().listen((_) {
      if (_currentType != null) _reloadCategories(_currentType!);
    });

    await _reloadCategories(type);
  }

  Future<void> _reloadCategories(CategoryType type) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    final defaultCategories = type == CategoryType.income
        ? AppCategories.incomeCategories
        : AppCategories.expenseCategories;

    try {
      final userCategories = hiveService.getCategoriesByType(type);
      final allCategories = [...defaultCategories, ...userCategories];
      emit(
        state.copyWith(
          status: CategoriesStatus.loaded,
          categories: allCategories,
        ),
      );
    } catch (e) {
      log('Failed to load categories by type: $e');
      emit(
        state.copyWith(
          status: CategoriesStatus.error,
          errorMessage: 'Failed to load categories',
        ),
      );
    }
  }

  // delete a category
  Future<bool> deleteCategory(CategoryModel category) async {
    try {
      await hiveService.deleteCategory(category);

      final updated = state.categories
          .where((c) => c.key != category.key)
          .toList();

      emit(state.copyWith(categories: updated));
      log('Category deleted: ${category.title}');
      return true;
    } catch (e) {
      log('Failed to delete category: $e');
      emit(state.copyWith(errorMessage: 'Failed to delete category'));
      return false;
    }
  }

  // update an existing category
  Future<bool> updateCategory(CategoryModel category) async {
    try {
      await hiveService.updateCategory(category);

      final updated = state.categories
          .map((c) => c.key == category.key ? category : c)
          .toList();

      emit(state.copyWith(categories: updated));
      log('Category updated: ${category.title}');
      return true;
    } catch (e) {
      log('Failed to update category: $e');
      emit(state.copyWith(errorMessage: 'Failed to update category'));
      return false;
    }
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    log('closed');
    return super.close();
  }
}
