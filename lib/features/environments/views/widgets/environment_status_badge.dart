import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class EnvironmentStatusBadge extends StatelessWidget {
  const EnvironmentStatusBadge({
    super.key,
    required this.isClosed,
  });

  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isClosed
            ? Colors.white.withValues(alpha: 0.08)
            : const Color(0xFF4CAF50).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        isClosed ? 'Closed' : 'Active',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isClosed ? Colors.white54 : const Color(0xFF4CAF50),
        ),
      ),
    );
  }
}
