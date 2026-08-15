import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_type_drop_down_menu.dart';

class NewCategoryTypeField extends StatelessWidget {
  const NewCategoryTypeField({super.key});

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
            child: const NewCategoryTypeDropDownMenu(),
          ),
        ],
      ),
    );
  }
}
