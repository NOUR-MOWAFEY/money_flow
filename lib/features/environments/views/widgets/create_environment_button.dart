import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_button.dart';

class CreateEnvironmentButton extends StatelessWidget {
  const CreateEnvironmentButton({
    super.key,
    required this.color,
    required this.onTap,
    this.title = 'Create Environment',
  });

  final Color color;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: title,
      color: color,
      onTap: onTap,
    );
  }
}
