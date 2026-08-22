import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/custom_add_category_button.dart';
import 'package:money_flow/features/categories/views/widgets/manage_categories_view_body.dart';

class ManageCategoriesView extends StatelessWidget {
  const ManageCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Manage Categories',
        actions: [CustomAddCategoryButton()],
      ),

      body: BlocProvider(
        create: (context) =>
            CategoriesCubit(HiveService())..getUserCreatedCategories(),
        child: const SafeArea(child: ManageCategoriesViewBody()),
      ),
    );
  }
}
