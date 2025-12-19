import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_categories.dart';
import 'package:money_flow/widgets/transaction_tile.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,

    required this.categoryController,
    required this.transactionType,
    required this.categoryTitle,
    required this.iconNotifier,
  });
  static late String category;
  final TextEditingController categoryController;
  final ValueNotifier<int> transactionType;
  final ValueNotifier<String> categoryTitle;
  final ValueNotifier<IconData?> iconNotifier;

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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: ListView.separated(
          itemCount: transactionType.value == 0
              ? AppCategories.expenseCategories.length
              : AppCategories.incomeCategories.length,
          itemBuilder: (context, index) => TransactionTile(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            onTap: () {
              category = transactionType.value == 0
                  ? AppCategories.expenseCategories.keys.toList()[index]
                  : AppCategories.incomeCategories.keys.toList()[index];
              categoryController.text = category;
              categoryTitle.value = category;
              iconNotifier.value = transactionType.value == 0
                  ? AppCategories.expenseCategories.values.toList()[index]
                  : AppCategories.incomeCategories.values.toList()[index];
              Navigator.pop(context);
            },
            isLastOne: false,
            isCategory: true,
            icon: transactionType.value == 0
                ? AppCategories.expenseCategories.values.toList()[index]
                : AppCategories.incomeCategories.values.toList()[index],
            title: transactionType.value == 0
                ? AppCategories.expenseCategories.keys.toList()[index]
                : AppCategories.incomeCategories.keys.toList()[index],
          ),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
  }
}
