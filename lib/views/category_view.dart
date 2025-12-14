import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Select Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => TransactionTile(
            isLastOne: false,
            isCategory: true,
            icon: AppCategories.expenseCategories.values.toList()[index],
            title: AppCategories.expenseCategories.keys.toList()[index],
          ),
        ),
      ),
    );
  }
}
