import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/utils/string_utils.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/data/models/category_model.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';

class NewCategoryTypeDropDownMenu extends StatelessWidget {
  const NewCategoryTypeDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<CategoryType>(
            isExpanded: true,

            items: CategoryType.values
                .map(
                  (type) => DropdownItem<CategoryType>(
                    value: type,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        StringUtils.capitalizeFirstLetter(type.name),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                )
                .toList(),

            onChanged: (newValue) {
              if (newValue != null) {
                context.read<NewCategoryCubit>().selectType(
                  StringUtils.capitalizeFirstLetter(newValue.name),
                );
              }
            },

            hint: CustomText(state.selectedType ?? 'Category type'),

            buttonStyleData: ButtonStyleData(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.black1,
              ),
            ),

            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 22,
            ),

            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              isOverButton: true,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.black1,
                boxShadow: const [],
              ),
            ),

            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        );
      },
    );
  }
}
