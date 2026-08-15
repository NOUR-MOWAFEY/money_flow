import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_button.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_cubit.dart';
import 'package:money_flow/features/categories/view_models/new_category_cubit/new_category_state.dart';

class CreateCategoryButton extends StatelessWidget {
  const CreateCategoryButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewCategoryCubit, NewCategoryState>(
      builder: (context, state) {
        return state is NewCategoryLoading
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 20, right: 20),
                child: CustomButton(
                  title: 'Create',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<NewCategoryCubit>().saveCategory();
                    }
                  },
                ),
              );
      },
    );
  }
}
