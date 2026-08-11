import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/widgets/custom_text.dart';

class NewCategoryColorButton extends StatelessWidget {
  const NewCategoryColorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const CustomText('Color: '),
        const SizedBox(height: 8),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
