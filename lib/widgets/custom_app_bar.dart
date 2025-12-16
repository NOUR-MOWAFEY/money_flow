import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(child: Text('N')),
        SizedBox(width: 12),
        const Text(
          'Hi, Nour',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(83, 158, 158, 158),
            borderRadius: BorderRadius.circular(70),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.restart_alt_outlined,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
