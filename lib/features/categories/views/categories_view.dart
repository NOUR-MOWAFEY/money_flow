import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/category_cubit/category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/categories_view_body.dart';
import 'package:money_flow/features/categories/views/widgets/custom_add_button.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key, required this.type, required this.category});
  final CategoryType type;
  final ValueNotifier<CategoryModel?> category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const CustomText('Select Category'),
        actions: [const CustomAddButton()],
      ),
      body: BlocProvider(
        create: (context) =>
            CategoriesCubit(HiveService())..getCategoriesByType(type),
        child: CategoriesViewBody(transactionType: type, category: category),
      ),
    );
  }
}
