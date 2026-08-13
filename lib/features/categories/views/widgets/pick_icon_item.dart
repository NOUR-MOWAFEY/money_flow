import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/categories/data/models/category_icon.dart';

class PickIconItem extends StatelessWidget {
  const PickIconItem({super.key, required this.item, required this.isSelected});

  final CategoryIcon item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.greyTrasparent : AppColors.secondaryColor,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 28),
          const SizedBox(height: 8),

          _buildCategoryLabel(
            item.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

Widget _buildCategoryLabel(String name, {required TextStyle style}) {
  final isSingleWord = !name.trim().contains(' ');

  return AutoSizeText(
    name,
    maxLines: isSingleWord ? 1 : 2,
    minFontSize: 8,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: style,
  );
}
