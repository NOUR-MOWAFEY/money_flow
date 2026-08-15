import 'package:money_flow/features/categories/data/models/category_model.dart';

enum CategoriesStatus { initial, loading, loaded, error }

class CategoriesState {
  const CategoriesState({
    required this.status,
    required this.categories,
    required this.errorMessage,
  });

  factory CategoriesState.initial() => const CategoriesState(
    status: CategoriesStatus.initial,
    categories: [],
    errorMessage: null,
  );

  final CategoriesStatus status;
  final List<CategoryModel> categories;
  final String? errorMessage;

  List<CategoryModel> get expenseCategories =>
      categories.where((c) => c.categoryType == CategoryType.expenses).toList();

  List<CategoryModel> get incomeCategories =>
      categories.where((c) => c.categoryType == CategoryType.income).toList();

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<CategoryModel>? categories,
    String? errorMessage,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
    );
  }
}
