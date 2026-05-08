import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';
import 'package:money_flow/widgets/categories_view_body.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/custom_back_button.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
    required this.transactionType,
    required this.category,
  });
  final TransactionType transactionType;
  final ValueNotifier<CategoryModel> category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Select Category'),
      ),
      body: CategoriesViewBody(
        transactionType: transactionType,
        category: category,
      ),
    );
  }
}
