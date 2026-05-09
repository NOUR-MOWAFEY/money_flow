import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';

class AppCategories {
  static const List<CategoryModel> expenseCategories = [
    // --- existing ---
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
    // --- new ---
    CategoryModel(title: 'Dining Out', icon: Icons.restaurant),
    CategoryModel(title: 'Coffee', icon: Icons.local_cafe),
    CategoryModel(title: 'Alcohol', icon: Icons.local_bar),
    CategoryModel(title: 'Fitness', icon: Icons.fitness_center),
    CategoryModel(title: 'Beauty', icon: Icons.face),
    CategoryModel(title: 'Clothing', icon: Icons.checkroom),
    CategoryModel(title: 'Electronics', icon: Icons.devices),
    CategoryModel(title: 'Fuel', icon: Icons.local_gas_station),
    CategoryModel(title: 'Parking', icon: Icons.local_parking),
    CategoryModel(title: 'Insurance', icon: Icons.security),
    CategoryModel(title: 'Taxes', icon: Icons.account_balance),
    CategoryModel(title: 'Repairs', icon: Icons.build),
    CategoryModel(title: 'Pets', icon: Icons.pets),
    CategoryModel(title: 'Kids', icon: Icons.child_care),
    CategoryModel(title: 'Books', icon: Icons.menu_book),
    CategoryModel(title: 'Games', icon: Icons.sports_esports),
    CategoryModel(title: 'Charity', icon: Icons.volunteer_activism),
    CategoryModel(title: 'Gifts', icon: Icons.redeem),
    CategoryModel(title: 'Other', icon: Icons.more_horiz),
  ];

  static const List<CategoryModel> incomeCategories = [
    // --- existing ---
    CategoryModel(title: 'Salary', icon: Icons.work),
    CategoryModel(title: 'Freelance', icon: Icons.laptop),
    CategoryModel(title: 'Business', icon: Icons.business_center),
    CategoryModel(title: 'Investment', icon: Icons.trending_up),
    CategoryModel(title: 'Gift', icon: Icons.card_giftcard),
    CategoryModel(title: 'Bonus', icon: Icons.star),
    // --- new ---
    CategoryModel(title: 'Rental Income', icon: Icons.house),
    CategoryModel(title: 'Dividends', icon: Icons.pie_chart),
    CategoryModel(title: 'Commission', icon: Icons.percent),
    CategoryModel(title: 'Side Hustle', icon: Icons.handyman),
    CategoryModel(title: 'Selling', icon: Icons.sell),
    CategoryModel(title: 'Refund', icon: Icons.replay),
    CategoryModel(title: 'Pension', icon: Icons.elderly),
    CategoryModel(title: 'Scholarship', icon: Icons.emoji_events),
    CategoryModel(title: 'Other', icon: Icons.more_horiz),
  ];
}
