import 'package:money_flow/features/categories/data/models/category_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded({
    required this.categories,
  });

  final List<CategoryModel> categories;

  List<CategoryModel> get expenseCategories =>
      categories
          .where((category) => category.categoryType == CategoryType.expenses)
          .toList();

  List<CategoryModel> get incomeCategories =>
      categories
          .where((category) => category.categoryType == CategoryType.income)
          .toList();
}

class CategoriesError extends CategoriesState {
  CategoriesError(this.errMessage);

  final String errMessage;
}