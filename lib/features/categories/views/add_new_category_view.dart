import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/view_models/icon_picker_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/views/widgets/add_new_category_view_body.dart';

class AddNewCategoryView extends StatelessWidget {
  const AddNewCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const CustomText('Add New Category'),
      ),
      body: BlocProvider(
        create: (context) => NewCategoryCubit(),
        child: const AddNewCategoryViewBody(),
      ),
    );
  }
}
