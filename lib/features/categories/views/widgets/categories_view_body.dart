import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_cubit.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_state.dart';
import 'package:money_flow/features/categories/views/widgets/categories_grid.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({
    super.key,
    required this.transactionType,
    required this.category,
  });

  final CategoryType transactionType;
  final ValueNotifier<CategoryModel?> category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesLoaded && category.value != null) {
            final isAvailable = state.categories.any(
              (c) => c.title == category.value?.title,
            );
            if (!isAvailable) {
              category.value = null;
            }
          }
        },

        builder: (context, state) {
          if (state is CategoriesLoaded) {
            return CategoriesGrid(
              category: category,
              categories: state.categories,
            );
          }

          if (state is CategoriesError) {
            return Center(child: Text(state.errMessage));
          }

          return const CustomLoading();
        },
      ),
    );
  }
}
