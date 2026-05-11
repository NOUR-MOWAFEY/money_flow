import 'package:flutter/material.dart';
import 'package:money_flow/models/category_model.dart';

class AppCategories {
  static const defaultCategory = CategoryModel(
    title: "Category",
    icon: Icons.category_rounded,
    color: Colors.transparent,
  );
  
  static const List<CategoryModel> expenseCategories = [
    CategoryModel(
      title: 'Food',
      icon: Icons.fastfood,
      color: Color(0xFFFF6B35),
    ),
    CategoryModel(
      title: 'Transport',
      icon: Icons.directions_car,
      color: Color(0xFF4A90D9),
    ),
    CategoryModel(
      title: 'Shopping',
      icon: Icons.shopping_bag,
      color: Color(0xFFE91E8C),
    ),
    CategoryModel(
      title: 'Bills',
      icon: Icons.receipt_long,
      color: Color(0xFF607D8B),
    ),
    CategoryModel(title: 'Rent', icon: Icons.home, color: Color(0xFF795548)),
    CategoryModel(
      title: 'Health',
      icon: Icons.local_hospital,
      color: Color(0xFFE53935),
    ),
    CategoryModel(
      title: 'Education',
      icon: Icons.school,
      color: Color(0xFF1E88E5),
    ),
    CategoryModel(
      title: 'Entertainment',
      icon: Icons.movie,
      color: Color(0xFF8E24AA),
    ),
    CategoryModel(
      title: 'Travel',
      icon: Icons.flight,
      color: Color(0xFF00ACC1),
    ),
    CategoryModel(
      title: 'Groceries',
      icon: Icons.local_grocery_store,
      color: Color(0xFF43A047),
    ),
    CategoryModel(
      title: 'Subscriptions',
      icon: Icons.subscriptions,
      color: Color(0xFFFF864F),
    ),
    CategoryModel(
      title: 'Coffee',
      icon: Icons.local_cafe,
      color: Color(0xFF6D4C41),
    ),
    CategoryModel(
      title: 'Fitness',
      icon: Icons.fitness_center,
      color: Color(0xFF00897B),
    ),
    CategoryModel(title: 'Beauty', icon: Icons.face, color: Color(0xFFF06292)),
    CategoryModel(
      title: 'Clothing',
      icon: Icons.checkroom,
      color: Color(0xFF7B1FA2),
    ),
    CategoryModel(
      title: 'Electronics',
      icon: Icons.devices,
      color: Color(0xFF1565C0),
    ),
    CategoryModel(
      title: 'Fuel',
      icon: Icons.local_gas_station,
      color: Color(0xFFFF8F00),
    ),
    CategoryModel(
      title: 'Insurance',
      icon: Icons.security,
      color: Color(0xFF37474F),
    ),
    CategoryModel(
      title: 'Repairs',
      icon: Icons.build,
      color: Color(0xFF78909C),
    ),
    CategoryModel(title: 'Pets', icon: Icons.pets, color: Color(0xFFEF8C00)),
    CategoryModel(
      title: 'Kids',
      icon: Icons.child_care,
      color: Color(0xFF26C6DA),
    ),
    CategoryModel(
      title: 'Books',
      icon: Icons.menu_book,
      color: Color(0xFF5C6BC0),
    ),
    CategoryModel(
      title: 'Charity',
      icon: Icons.volunteer_activism,
      color: Color(0xFF71864B),
    ),
    CategoryModel(title: 'Gifts', icon: Icons.redeem, color: Color(0xFFEC407A)),
    CategoryModel(
      title: 'Other',
      icon: Icons.more_horiz,
      color: Color(0xFF9E9E9E),
    ),
  ];

  static const List<CategoryModel> incomeCategories = [
    CategoryModel(title: 'Salary', icon: Icons.work, color: Color(0xFF2E7D32)),
    CategoryModel(
      title: 'Freelance',
      icon: Icons.laptop,
      color: Color(0xFF00838F),
    ),
    CategoryModel(
      title: 'Business',
      icon: Icons.business_center,
      color: Color(0xFF1565C0),
    ),
    CategoryModel(
      title: 'Investment',
      icon: Icons.trending_up,
      color: Color(0xFF008EE2),
    ),
    CategoryModel(
      title: 'Gift',
      icon: Icons.card_giftcard,
      color: Color(0xFFAD1457),
    ),
    CategoryModel(title: 'Bonus', icon: Icons.star, color: Color(0xFFF9A825)),
    CategoryModel(
      title: 'Commission',
      icon: Icons.percent,
      color: Color(0xFF6A1B9A),
    ),
    CategoryModel(
      title: 'Side Hustle',
      icon: Icons.handyman,
      color: Color(0xFF4E342E),
    ),
    CategoryModel(title: 'Selling', icon: Icons.sell, color: Color(0xFF00695C)),
    CategoryModel(
      title: 'Refund',
      icon: Icons.replay,
      color: Color(0xFF005384),
    ),
    CategoryModel(
      title: 'Other',
      icon: Icons.more_horiz,
      color: Color(0xFF9E9E9E),
    ),
  ];
}
