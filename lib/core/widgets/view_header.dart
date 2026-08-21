import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key, required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const SizedBox(height: AppDimensions.viewTopSpace),

        CustomText(
          title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),

        subtitle == null ? const SizedBox() : const SizedBox(height: 8),

        subtitle == null
            ? const SizedBox()
            : CustomText(
                subtitle!,
                style: const TextStyle(fontSize: 14, color: Colors.white54),
              ),

        SizedBox(height: 24),
      ],
    );
  }
}
