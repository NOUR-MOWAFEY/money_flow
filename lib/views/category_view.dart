import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/views/add_transaction_view.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});
  static late String category;

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
        child: ListView.separated(
          itemCount: AddTransactionView.transactionType.value == 0
              ? AppCategories.expenseCategories.length
              : AppCategories.incomeCategories.length,
          itemBuilder: (context, index) => TransactionTile(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            onTap: () {
              category = AddTransactionView.transactionType.value == 0
                  ? AppCategories.expenseCategories.keys.toList()[index]
                  : AppCategories.incomeCategories.keys.toList()[index];
              AddTransactionView.categoryController.text = category;
              AddTransactionView.categoryTitle.value = category;
              AddTransactionView.icon =
                  AddTransactionView.transactionType.value == 0
                  ? AppCategories.expenseCategories.values.toList()[index]
                  : AppCategories.incomeCategories.values.toList()[index];
              Navigator.pop(context);
            },
            isLastOne: false,
            isCategory: true,
            icon: AddTransactionView.transactionType.value == 0
                ? AppCategories.expenseCategories.values.toList()[index]
                : AppCategories.incomeCategories.values.toList()[index],
            title: AddTransactionView.transactionType.value == 0
                ? AppCategories.expenseCategories.keys.toList()[index]
                : AppCategories.incomeCategories.keys.toList()[index],
          ),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 4);
          },
        ),
      ),
    );
  }
}
