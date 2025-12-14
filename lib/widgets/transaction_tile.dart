import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.isLastOne,
    this.isCategory = false,
    required this.icon,
    required this.title,
  });
  final bool isLastOne;
  final bool isCategory;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: isLastOne ? null : 80,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: BoxBorder.all(color: AppColors.primaryColor),
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
                        : Text('jun 06 2025', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Spacer(),
                isCategory ? SizedBox() : Text('-EGP 100'),
              ],
            ),
          ),
          isLastOne ? SizedBox(height: 100) : SizedBox(),
        ],
      ),
    );
  }
}
