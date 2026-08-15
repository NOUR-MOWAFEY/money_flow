import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/views/widgets/edit_category_type_drop_down_menu.dart';

class EditCategoryTypeField extends StatelessWidget {
  const EditCategoryTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText('Category Type: '),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: const EditCategoryTypeDropDownMenu(),
          ),
        ],
      ),
    );
  }
}
