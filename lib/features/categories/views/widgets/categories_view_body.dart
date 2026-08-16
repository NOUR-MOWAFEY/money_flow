import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_cubit.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_state.dart';
import 'package:money_flow/features/categories/views/widgets/categories_grid.dart';

class CategoriesViewBody extends StatefulWidget {
  const CategoriesViewBody({
    super.key,
    required this.transactionType,
    required this.category,
  });
  final CategoryType transactionType;
  final ValueNotifier<CategoryModel?> category;

  @override
  State<CategoriesViewBody> createState() => _CategoriesViewBodyState();
}

class _CategoriesViewBodyState extends State<CategoriesViewBody> {
  late final CategoriesCubit _categoriesCubit;

  @override
  void initState() {
    super.initState();
    _categoriesCubit = context.read<CategoriesCubit>();
    // Loads + subscribes to live Hive updates for this type
    _categoriesCubit.getCategoriesByType(widget.transactionType);
  }

  @override
  void dispose() {
    // Use the cubit's CURRENT state, not a stale snapshot from initState
    final currentCategories = _categoriesCubit.state.categories;
    final isAvailable = currentCategories.any(
      (category) => category.title == widget.category.value?.title,
    );

    if (!isAvailable) {
      Future.microtask(() {
        widget.category.value = null;
      });
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == CategoriesStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            );
          }

          return CategoriesGrid(category: widget.category);
        },
      ),
    );
  }
}
