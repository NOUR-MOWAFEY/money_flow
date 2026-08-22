import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/add_new_category_view_body.dart';
import 'package:money_flow/features/categories/views/widgets/create_category_button.dart';

class AddNewCategoryView extends StatefulWidget {
  const AddNewCategoryView({super.key});

  @override
  State<AddNewCategoryView> createState() => _AddNewCategoryViewState();
}

class _AddNewCategoryViewState extends State<AddNewCategoryView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) => NewCategoryCubit(HiveService()),
          child: Scaffold(
            appBar: const CustomAppBar(title: 'Add New Category'),

            body: const AddNewCategoryViewBody(),

            bottomNavigationBar: CreateCategoryButton(formKey: formKey),
          ),
        ),
      ),
    );
  }
}
