import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/core/widgets/custom_search_bar.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_cubit.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_state.dart';
import 'package:money_flow/features/categories/views/widgets/categories_list_view.dart';

class ManageCategoriesViewBody extends StatelessWidget {
  const ManageCategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.viewPadding,
      ),

      child: Column(
        crossAxisAlignment: .start,

        children: [
          const _CategoriesSearchBar(),

          const SizedBox(height: 4),

          Expanded(
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  return CategoriesListView(categories: state.categories);
                }

                if (state is CategoriesError) {
                  return Center(
                    child: CustomText(state.errMessage, textAlign: .center),
                  );
                }

                return CustomLoading();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesSearchBar extends StatelessWidget {
  const _CategoriesSearchBar();

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      hint: 'Search for Category',
      onChanged: context.read<CategoriesCubit>().searchCategories,
    );
  }
}
