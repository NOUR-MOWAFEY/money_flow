import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/edit_category_cubit/edit_category_state.dart';

class EditCategoryButton extends StatelessWidget {
  const EditCategoryButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCategoryCubit, EditCategoryState>(
      builder: (context, state) {
        return state is EditCategoryLoading
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 20, right: 20),
                child: CustomButton(
                  title: 'Save',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<EditCategoryCubit>().updateCategory();
                    }
                  },
                ),
              );
      },
    );
  }
}
