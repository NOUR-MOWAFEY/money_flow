import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_loading.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_color_button.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_icon_button.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_name_field.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_type_field.dart';

class AddNewCategoryViewBody extends StatelessWidget {
  const AddNewCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<NewCategoryCubit, NewCategoryState>(
        buildWhen: (previous, current) =>
            previous is NewCategoryLoading != current is NewCategoryLoading,

        listener: (context, state) {
          if (state is NewCategorySuccess) {
            Navigator.pop(context);
          } else if (state is NewCategoryFailure) {
            ShowToastification.failure(context, state.errorMessage);
          }
        },

        builder: (context, state) {
          return state is NewCategoryLoading
              ? const CustomLoading()
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewCategoryNameField(),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        // icon
                        NewCategoryIconButton(),

                        SizedBox(width: 12),

                        // color
                        NewCategoryColorButton(),

                        SizedBox(width: 12),

                        // type
                        NewCategoryTypeField(),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
