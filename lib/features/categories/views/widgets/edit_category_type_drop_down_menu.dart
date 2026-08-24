import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_dropdown.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';

class EditCategoryTypeDropDownMenu extends StatelessWidget {
  const EditCategoryTypeDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryCubit, EditCategoryState>(
      builder: (context, state) {
        return CustomDropdown<CategoryType>(
          items: CategoryType.values,

          itemLabelBuilder: (type) =>
              StringUtils.capitalizeFirstLetter(type.name),

          hintText: state.selectedType ?? 'Category type',

          onChanged: (newValue) {
            if (newValue != null) {
              context.read<EditCategoryCubit>().selectType(
                StringUtils.capitalizeFirstLetter(newValue.name),
              );
            }
          },
        );
      },
    );
  }
}
