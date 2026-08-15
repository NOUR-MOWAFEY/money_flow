import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  IconData icon;

  @HiveField(2)
  Color color;

  @HiveField(3)
  CategoryType categoryType;

  CategoryModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.categoryType,
  });
}

@HiveType(typeId: 3)
enum CategoryType {
  @HiveField(0)
  expenses,
  @HiveField(1)
  income,
}
