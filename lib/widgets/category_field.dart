import 'package:flutter/material.dart';
import 'package:money_flow/views/categories_view.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/custom_text_form_field.dart';

class CategoryField extends StatefulWidget {
  const CategoryField({
    super.key,
    required this.category,
    required this.transactionType,
  });

  final Map<String, IconData> category;
  final TransactionType transactionType;

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  late TextEditingController categoryController;

  @override
  void initState() {
    categoryController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFiled(
      icon: widget.category.values.first,
      title: widget.category.keys.first,
      isEnabled: false,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesView(
              transactionType: widget.transactionType,
              categoryController: categoryController,
            ),
          ),
        );
      },
    );
  }
}
