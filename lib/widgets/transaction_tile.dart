import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.isLastOne,
    this.isCategory = false,
    required this.icon,
    required this.title,
    this.amount,
    this.date,
    this.onTap,
    this.isFirstOne = false,
    this.padding,
    this.onLongPress,
  });
  final bool isLastOne;
  final bool isCategory;
  final IconData icon;
  final String title;
  final String? amount;
  final String? date;
  final void Function()? onTap;
  final bool isFirstOne;
  final EdgeInsetsGeometry? padding;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: isLastOne ? null : 80,
      child: Column(
        children: [
          isFirstOne ? const SizedBox(height: 20) : SizedBox(),
          GestureDetector(
            onLongPress: onLongPress,
            onTap: onTap,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                border: isCategory
                    ? BoxBorder.all(color: AppColors.primaryColor)
                    : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    minRadius: 25,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    child: Icon(icon),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      isCategory
                          ? SizedBox()
                          : Text(date ?? '', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Spacer(),
                  isCategory ? SizedBox() : Text(amount ?? ''),
                ],
              ),
            ),
          ),
          isLastOne ? SizedBox(height: 100) : SizedBox(),
        ],
      ),
    );
  }
}
