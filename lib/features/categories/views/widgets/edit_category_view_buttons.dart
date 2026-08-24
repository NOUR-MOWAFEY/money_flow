import 'package:flutter/material.dart';
import 'package:money_flow/features/categories/views/widgets/delete_category_button.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_button.dart';

class EditCategoryViewButtons extends StatelessWidget {
  const EditCategoryViewButtons({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, left: 20, right: 20),
      child: Row(
        children: [
          const Expanded(child: DeleteCategoryButton()),

          const SizedBox(width: 8),

          Expanded(child: EditCategoryButton(formKey: formKey)),
        ],
      ),
    );
  }
}
