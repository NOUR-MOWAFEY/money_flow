import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          size: 24,
          Icons.arrow_back_rounded,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
