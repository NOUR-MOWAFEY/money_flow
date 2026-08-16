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
  //     final categories = hiveService.getCategories();
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

  List<CategoryModel> getAllCategories() {
    final defalutCategories = [
      ...AppCategories.expenseCategories,
      ...AppCategories.incomeCategories,
    ];

    final List<CategoryModel> categories = defalutCategories;

    

    try {
      categories.addAll(hiveService.getCategories());
    } catch (e) {
      log('Couldn\'t get categories');
    }

    return categories;
  }

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

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    log('closed');
    return super.close();
  }
}
