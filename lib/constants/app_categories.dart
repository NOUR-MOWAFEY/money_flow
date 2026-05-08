import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';


class AppCategories {
  static const List<CategoryModel> expenseCategories = [
    CategoryModel(title: 'Food', icon: Icons.fastfood),
    CategoryModel(title: 'Transport', icon: Icons.directions_car),
    CategoryModel(title: 'Shopping', icon: Icons.shopping_bag),
    CategoryModel(title: 'Bills', icon: Icons.receipt_long),
    CategoryModel(title: 'Rent', icon: Icons.home),
    CategoryModel(title: 'Health', icon: Icons.local_hospital),
    CategoryModel(title: 'Education', icon: Icons.school),
    CategoryModel(title: 'Entertainment', icon: Icons.movie),
    CategoryModel(title: 'Travel', icon: Icons.flight),
    CategoryModel(title: 'Groceries', icon: Icons.local_grocery_store),
    CategoryModel(title: 'Subscriptions', icon: Icons.subscriptions),
    CategoryModel(title: 'Other', icon: Icons.more_horiz),
  ];

  static const List<CategoryModel> incomeCategories = [
    CategoryModel(title: 'Salary', icon: Icons.work),
    CategoryModel(title: 'Freelance', icon: Icons.laptop),
    CategoryModel(title: 'Business', icon: Icons.business_center),
    CategoryModel(title: 'Investment', icon: Icons.trending_up),
    CategoryModel(title: 'Gift', icon: Icons.card_giftcard),
    CategoryModel(title: 'Bonus', icon: Icons.star),
    CategoryModel(title: 'Other', icon: Icons.more_horiz),
  ];
}
