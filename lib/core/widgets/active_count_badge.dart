import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

/// Reusable pill badge indicating the active count of items (such as environments).
class ActiveCountBadge extends StatelessWidget {
  const ActiveCountBadge({
    super.key,
    required this.count,
    this.label = 'Active',
    this.color = const Color(0xFF10B981),
    this.showIcon = true,
    this.icon = Icons.layers_rounded,
    this.fontSize = 11,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  });

  final int count;
  final String label;
  final Color color;
  final bool showIcon;
  final IconData icon;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              icon,
              size: fontSize + 3,
              color: color,
            ),
            const SizedBox(width: 4),
          ],
          CustomText(
            '$count $label',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
