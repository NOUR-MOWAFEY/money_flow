import 'package:flutter/material.dart';
import 'package:money_flow/widgets/custom_back_button.dart';
import 'package:money_flow/widgets/custom_text.dart';

class AddTransactionAppBar extends StatelessWidget {
  const AddTransactionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          CustomBackButton(),

          SizedBox(width: 8),

          CustomText(
            'Add Transaction',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
