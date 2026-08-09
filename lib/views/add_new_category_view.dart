import 'package:flutter/material.dart';
import 'package:money_flow/widgets/custom_back_button.dart';
import 'package:money_flow/widgets/custom_text.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class AddNewCategoryView extends StatelessWidget {
  const AddNewCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const CustomText('Add New Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            CustomText('Category Name: ', style: TextStyle()),
            CustomTextFormFiled(
              isNormalTextField: true,
              showCursor: true,
              showPrefixIcon: false,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              title: 'sadwad',
            ),
          ],
        ),
      ),
    );
  }
}
