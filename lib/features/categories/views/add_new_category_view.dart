import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_back_button.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_color_button.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_icon_button.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_name_field.dart';
import 'package:money_flow/features/categories/views/widgets/new_category_type_field.dart';

class AddNewCategoryView extends StatelessWidget {
  const AddNewCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const CustomText('Add New Category'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
        ),
      ),
    );
  }
}
