import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_dropdown.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';

class NewCategoryTypeDropDownMenu extends StatelessWidget {
  const NewCategoryTypeDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        return CustomDropdown<CategoryType>(
          items: CategoryType.values,

          itemLabelBuilder: (type) =>
              StringUtils.capitalizeFirstLetter(type.name),

          hintText: state.selectedType ?? 'Category type',

          onChanged: (newValue) {
            if (newValue != null) {
              context.read<NewCategoryCubit>().selectType(
                StringUtils.capitalizeFirstLetter(newValue.name),
              );
            }
          },
        );
      },
    );
  }
}
