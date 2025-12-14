import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.isLastOne});
  final bool isLastOne;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLastOne ? null : 80,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: 25,
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                child: Icon(Icons.airplanemode_active_outlined),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('jun 06 2025', style: TextStyle(fontSize: 12)),
                ],
              ),
              Spacer(),
              Text('-EGP 100'),
            ],
          ),
          isLastOne ? SizedBox(height: 100) : SizedBox(),
        ],
      ),
    );
  }
}
