import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

/// Reusable metric display showing a colored icon avatar, a small label,
/// and a bold formatted value.
class StatMetricItem extends StatelessWidget {
  const StatMetricItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.padding,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: color.withValues(alpha: 0.16),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: CustomText(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (padding != null) {
      return Padding(padding: padding!, child: content);
    }
    return content;
  }
}
