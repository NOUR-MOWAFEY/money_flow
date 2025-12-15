import 'package:flutter/material.dart';

class AppCategories {
  static final Map<String, IconData> expenseCategories = const {
    'Food': Icons.fastfood,
    'Transport': Icons.directions_car,
    'Shopping': Icons.shopping_bag,
    'Bills': Icons.receipt_long,
    'Rent': Icons.home,
    'Health': Icons.local_hospital,
    'Education': Icons.school,
    'Entertainment': Icons.movie,
    'Travel': Icons.flight,
    'Groceries': Icons.local_grocery_store,
    'Subscriptions': Icons.subscriptions,
    'Other': Icons.more_horiz,
  };

  static final Map<String, IconData> incomeCategories = const {
    'Salary': Icons.work,
    'Freelance': Icons.laptop,
    'Business': Icons.business_center,
    'Investment': Icons.trending_up,
    'Gift': Icons.card_giftcard,
    'Bonus': Icons.star,
    'Other': Icons.more_horiz,
  };
}
