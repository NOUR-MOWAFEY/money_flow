import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final IconData icon;
  final Color color;
  final CategoryType? categoryType;

  const CategoryModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.categoryType,
  });
}

enum CategoryType { expenses, income}
