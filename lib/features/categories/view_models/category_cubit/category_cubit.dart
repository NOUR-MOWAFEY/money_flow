import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_categories.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.hiveService) : super(CategoriesInitial());

  final HiveService hiveService;

  StreamSubscription? _categoriesSubscription;
  CategoryType? _currentType;
  List<CategoryModel> _allCategories = [];

  void searchCategories(String query) {
    final search = query.trim().toLowerCase();

    if (search.isEmpty) {
      emit(CategoriesLoaded(categories: _allCategories));
      return;
    }

    final filteredCategories = _allCategories.where((category) {
      return category.title.toLowerCase().contains(search);
    }).toList();

    emit(CategoriesLoaded(categories: filteredCategories));
  }

  void getUserCreatedCategories() {
    _categoriesSubscription ??= hiveService.watchCategories().listen((_) {
      _reloadUserCreatedCategories();
    });

    _reloadUserCreatedCategories();
  }

  void _reloadUserCreatedCategories() {
    try {
      final categories = hiveService.getCategories();

      _allCategories = categories;

      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      log('Couldn\'t get user categories: $e');

      emit(CategoriesError('Couldn\'t get categories'));
    }
  }

  Future<void> getCategoriesByType(CategoryType type) async {
    _currentType = type;

    _categoriesSubscription ??= hiveService.watchCategories().listen((_) {
      if (_currentType != null) {
        _reloadCategories(_currentType!);
      }
    });

    await _reloadCategories(type);
  }

  Future<void> _reloadCategories(CategoryType type) async {
    emit(CategoriesLoading());

    final defaultCategories = type == CategoryType.income
        ? AppCategories.incomeCategories
        : AppCategories.expenseCategories;

    try {
      final userCategories = hiveService.getCategoriesByType(type);

      final allCategories = [...defaultCategories, ...userCategories];

      emit(CategoriesLoaded(categories: allCategories));
    } catch (e) {
      log('Failed to load categories by type: $e');

      emit(CategoriesError('Failed to load categories'));
    }
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
