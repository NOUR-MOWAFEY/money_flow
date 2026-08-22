import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_view_body.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_view_buttons.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView({super.key, required this.category});

  final CategoryModel category;

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) =>
              EditCategoryCubit(widget.category, HiveService()),

          child: Scaffold(
            appBar: const CustomAppBar(title: 'Edit Category'),

            body: const EditCategoryViewBody(),

            bottomNavigationBar: EditCategoryViewButtons(formKey: formKey),
          ),
        ),
      ),
    );
  }
}
